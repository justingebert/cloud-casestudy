This is a case study to learn AWS 
# Process Thoughts + Notes:

- init git and GitHub
- init npm for transcoder
- sharp most popular image processing library (https://sharp.pixelplumbing.com/api-resize)
- create s3 bucket using terraform(havent done that before)
- log in to AWS using aws cli using cli user I created in IAM in console, did understand sso login
- set up a budget
- now try to push an image to s3 bucket
- thinking about creating an express server on ec2 to create an api to check the file size and the push to source s3 but serverless would be cheaper with changing loads
- lambda and gateway api have space limits that are too low for 100mb files
- I am looking for an google cloud run alternative, fargate seems similar but does not have a free tier
- use local zip for lambda -> later maybe also s3?
- had issues using Terraform on laptop -> imported
- created terraform cloud project -> cli -> remote execution
- add logging premission to lambda
- had a problem using shrap with lambda -> found that they adressed it in their documentation -> npm install --arch=x64 --platform=linux sharp (not optimal solution) -> didnt work -> npm install --platform=linux --arch=x64 sharp@0.32.6 -> worked
- confused about tf environments/workspaces -> should use them to have different states for different environments
- create express server with docker and test locally
- decided to sue app runner -> easy to use
- issues with aws sdk credentials in container
- had issues with region in app runner -> redeployed everything on eu-central-1 but there were issues with destroying and migrating ecr
- roles and policies are somehow did not get destroyed
- credentials are not working in Apprunner, it worked with hardcoding them into the image but thats not safe
- I looked into terraform workspaces with Terraform Cloud and cli, not sure how to use them
- refractor terraform to modules and add variables
- when destroying s3, the names are not available for a while, very annoying

# thoughts:

- use api gateway and pre-signed urls to upload files to s3 -> but does upload unnecessary files
- store tf state in s3 with versioning -> rolling back is easy or use Terraform cloud
- automate docker building and pushing to ecr on git commit to main or use repo with automatic deployment enabled

TODO:

- [ ] read s3 bucket names
- [X] migrate terraform to cloud
- [X] create a lambda function to resize an image
- [X] change lambda permissions
- [ ] transcoder lambda using sharp: To get the best performance select the largest memory available. A 1536 MB function provides ~12x more CPU time than a 128 MB function.
- [X] Create an express server to upload files to s3
- [ ] set variables for image type and size so api and terraform get them from the same place
- [ ] Look into pre-signed urls for s3

TODO PDF:

- [X] Images to be transcoded are delivered to a source AWS S3 bucket. Each image shall be immediately transcoded to a destination AWS S3 bucket.
- [X] Each input image shall be downscaled to two image proxies, which is 2048x2048 and
  1024x1024. The downscaled images should fit into these boxes keeping the existing aspect
  ratio. The transcoded images shall be of type JPG, no matter which input format was given.
- [X] The solution shall be implemented using state-of-the-art cloud patterns and development patterns (i.e. applying infrastructure as code)
- [X] The solution shall be implemented on our cloud provider AWS
- [X] The solution shall log image transcoding issues to ease operations.
- [X] The solution shall be configurable in terms of image sizes, S3 buckets, etc
- [X] The solution shall be capable of handling images of up to 100 MB each
- [X] The solution shall be capable of transcoding JPEG and PNG images only
- [X] The solution shall be highly scalable to handle peak demands
- [X] The solution shall not produce high costs if it isn’t in use. Ideally, there are no costs if not in use
- [X] The solution shall be easily reproducible to setup other environments (like STAGING, QA,
  PRODUCTION) from scratch, allowing development of new features as well as to ease
  integration with our partners.
- [X] The solution shall be versioned in order to all developing new features and rollbacks in case of any issues.
- [ ] The solution shall provide a REST API endpoint a client can POST a supported image to (as
  binary payload). In case the image is too big (in terms of binary size) or having the wrong type, it shall be rejected returning a 400 BAD REQUEST response code.
