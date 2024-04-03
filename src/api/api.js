import express from 'express';
import AWS from 'aws-sdk';
import { fileTypeFromBuffer } from 'file-type';


AWS.config.update({
    region: 'eu-central-1',
});


const s3 = new AWS.S3();

const app = express();
const port = 3000;

app.use(express.raw({ 
    type: '*/*', // Accept any type but treat as binary
    limit: '100mb' 
}));

console.log('AWS SDK Config:', AWS.config);
console.log('AWS Credentials:', AWS.config.credentials);

AWS.config.getCredentials(function(err) {
    if (err) {
      console.log('Error retrieving AWS credentials', err.stack); // Log error
    } else {
      console.log('AWS Credentials loaded successfully'); // Success logging
      console.log('Access Key:', AWS.config.credentials.accessKeyId);
      // You can add more AWS operation here knowing the credentials are loaded
    }
  });
  
AWS.config.credentials = new AWS.ECSCredentials({ });

app.post('/upload', async (req, res) => {
    if (!req.body) {
        return res.status(400).send('No file uploaded.');
    }

    const fileTypeResult = await fileTypeFromBuffer(req.body);

    //only allow PNG and JPEG
    if (!fileTypeResult || (fileTypeResult.mime !== 'image/png' && fileTypeResult.mime !== 'image/jpeg')) {
        return res.status(400).send('Unsupported file type.');
    }

    const fileName = `${Date.now()}.${fileTypeResult.ext}`;

    const params = {
        Bucket: 'jg-source-bucket-rb', //TODO process.env.S3_BUCKET_NAME 
        Key: fileName,
        Body: req.body,
        ContentType: fileTypeResult.mime
    };

    
    s3.upload(params, (err, data) => {
        if (err) {
            console.log('Error uploading file:', err);
            return res.status(500).send('Error uploading file.');
        } else {
            console.log('File uploaded successfully. File location:', data.Location);
            return res.status(200).send({
                message: 'File uploaded successfully.',
                location: data.Location
            });
        }
    });
});

app.listen(port, () => console.log(`Server running on port ${port}`));
