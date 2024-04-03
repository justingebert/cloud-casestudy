# Documentation:

- init git and github
- init npm for transcoder
- sharp most popular image processing library (https://sharp.pixelplumbing.com/api-resize)
- create s3 bucket using terraform(havent done that before)
- log into aws using aws cli using cli user i created in IAM in console, didnt undersand sso login
- set up budget
- now try to push image to s3 bucket
- thining about creating an express server on ec2 to create an api to check the file siyen and the npush to soruce s3 but serverless would be cheaper with chaning loads
- lambda and gatewaty api have spaclimtis that are to low for 100mb files
- i am looking for an google cloud run alternative, fargate seems similar but does not have a free tier
- use local zip for lambda -> later maybe also s3?
- had issues using terraform on laptop -> imported
- crreated terraform cloud project -> cli -> remote execution
- add logging premission to lambda
- had a problem using shrap with lambda -> found that they adressed it in their documentation -> npm install --arch=x64 --platform=linux sharp (not optimal solution) -> didnt work -> npm install --platform=linux --arch=x64 sharp@0.32.6 -> worked
- confused about tf envirometns/workspaces -> should use them to have different states for different enviroments
- create express server with docker and test locally
- decided to sue apprunner -> easy to use
- issues with aws sdk credentiasl in container
- had issues with region in apprunner -> redeployed eveything on eu-central-1 but there isserus with destroying and migrating ecr
- roles and policies are somehow did not get destroyed
- credentials are not working in apprunner, it worked with hardcoding them into the image but thats not safe
- looked into terraform workspaces with terraform cloud and cli, not sure how to use them
- refractor terraform to modules and add variables
- when destroying s3 the names are not available for a while, very annoying

# thoughts:

- use api gateway and presigned urls to upload files to s3 -> but does upload unessary files
- store tf state in s3 with versioning -> rolling back is easy or use terraform cloud
- automate docker buildin and pushing to ecr on git commit to main or use repo with automatic deploy enabled

TODO:

- [ ] read s3 bucket names
- [X] migrate terraform to cloud
- [X] create a lambda function to resize image
- [X] change lambda permissions
- [ ] transcoder lambda using sharp: To get the best performance select the largest memory available. A 1536 MB function provides ~12x more CPU time than a 128 MB function.
- [ ] create a express server to upload files to s3
- [ ] set varaibles for image type and size so api and terrform get them from the same place
- [ ] look into pre signed urls for s3

TODO PDF:

- [X] Images to be transcoded are delivered to a source AWS S3 bucket. Each image shall be immediately transcoded to a destination AWS S3 bucket.
- [X] Each input image shall be downscaled to two image proxies, which is 2048x2048 and
  1024x1024. The downscaled images should fit into these boxes keeping the existing aspect
  ratio. The transcoded images shall be of type JPG, no matter which input format was given.
- [X] The solution shall be implemented using state-of-the-art cloud patterns and development patterns (i.e. applying infrastructure as code)
- [X] The solution shall be implemented on our cloud provider AWS
- [X] The solution shall log image transcoding issues to ease operations.
- [ ] The solution shall be configurable in terms of image sizes, S3 buckets, etc
- [ ] The solution shall be capable of handling images of up to 100 MB each
- [ ] The solution shall be capable of transcoding JPEG and PNG images only
- [ ] The solution shall be highly scalable to handle peak demands
- [ ] The solution shall not produce high costs if it isn’t in use. Ideally there are no costs if not in use
- [ ] The solution shall be easily reproducible to setup other environments (like STAGING, QA,
  PRODUCTION) from scratch allowing development of new features as well as to ease
  integration with our partners.
- [ ] The solution shall be versioned in order to all developing new features and rollbacks in case of any issues.
- [ ] The solution shall provide a REST API endpoint a client can POST a supported image to (as
  binary payload). In case the image is too big (in terms of binary size) or having the wrong type, it shall be rejected returning a 400 BAD REQUEST response code.
