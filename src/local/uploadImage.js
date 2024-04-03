import AWS from 'aws-sdk';
import fs from 'fs';


AWS.config.update({
    region: 'eu-central-1',
});

const s3 = new AWS.S3();

const params = {
    Bucket: 'jg-source-bucket-2',
    Key: 'redbulllogo.png',
    Body: fs.createReadStream('../../img/Red-Bull-logo.png')
};

s3.upload(params, (err, data) => {
    if (err) {
        console.log('Error uploading file:', err);
    } else {
        console.log('File uploaded successfully. File location:', data.Location);
    }
});