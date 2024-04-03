const AWS = require('aws-sdk');
const sharp = require('sharp');
const path = require('path');
const s3 = new AWS.S3();

exports.handler = async (event) => {
  const sourceBucket = event.Records[0].s3.bucket.name; //read bucket name from event
  const key = decodeURIComponent(event.Records[0].s3.object.key.replace(/\+/g, ' ')); //object read key from event
  const destinationBucket = process.env.DEST_BUCKET; //destination bucket name (set in environment variables in the Lambda resource)

  const sizes = process.env.IMAGE_SIZES.split(',').map(size => parseInt(size, 10));

  console.log(`Image ${key} from bucket ${sourceBucket} triggered the Lambda function`);

  try {
    const originalImage = await s3.getObject({ Bucket: sourceBucket, Key: key }).promise();

    for (let size of sizes) {
      const resizedImage = await sharp(originalImage.Body)
        .resize(size, size, {
          fit: 'inside',
          withoutEnlargement: true
        })
        .toFormat('jpeg')
        .toBuffer();

      const originalName = path.basename(key, path.extname(key));
      const outputPath = `${originalName}-proxy-${size}.jpg`;

      //image to the destination bucket
      await s3.putObject({
        Bucket: destinationBucket,
        Key: outputPath,
        Body: resizedImage,
        ContentType: 'image/jpeg'
      }).promise();

      console.log(`Image resized to ${size}x${size} and uploaded to ${destinationBucket}/${outputPath}`);
    }
  } catch (error) {
    console.error('Error processing image:', error);
    throw error;
  }
};
