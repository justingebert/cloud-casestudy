const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

const inputImagePath = '../img/Red-Bull-logo.png';
const outputDir = '../img/resized-images/';


async function resizeImage(inputPath, outputDir, size) {
  try {
    const originalName = path.basename(inputPath, path.extname(inputPath));
    const outputPath = path.join(outputDir, `${originalName}-proxy-${size}.jpg`);

    await sharp(inputPath)
      .resize(size, size, {
        fit: 'inside',
        withoutEnlargement: true 
      })
      .toFormat('jpeg')
      .toFile(outputPath);

    console.log(`Image resized to ${size}x${size} and saved to ${outputPath}`);
  } catch (error) {
    console.error('Error resizing image:', error);
  }
}

resizeImage(inputImagePath, outputDir, 2048);
resizeImage(inputImagePath, outputDir, 1024);
