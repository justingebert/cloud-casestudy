#Documentation:

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

TODO:

- [ ] read s3 bucket names
- [ ] migrate terraform to cloud
- [ ] create a lambda function to resize image
- [ ] change lambda permissions
