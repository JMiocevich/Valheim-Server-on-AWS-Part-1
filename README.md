# Valheim on AWS SAM
For more instructions and setup go to [Valheim on AWS BlogPost](https://mechanicalrock.github.io/2022/04/04/valheim-server.html)


## Setup
The following/requirements are needed.
- Access to AWS account with access credentials avaliable for use,  [AWS Docs](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
- [VsCode](https://code.visualstudio.com) installed
- [NodeJs](https://nodejs.org/en/download/) installed
- [AWS Command Line Interface](https://aws.amazon.com/cli/) installed
- [AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html) installed
- Following github repo downloaded [Valheim Server](https://github.com/JMiocevich/valheim_server_aws_ts)
- [Discord WebHook](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks)

# Setup
- Install required packages using npm install.
- Edit the configuration section in `./ci/scripts/deploy.sh`
- Change the deployment region to preferred region, change server name (this will be a searchable item in Valheim server browser)
- Insert Discord WebHook
- Run ./ci/scripts/deploy.sh
- Goto secrets mananager and edit associated secret, will be the same as your server name
- To start server run `aws lambda invoke --function-name ${serverName}-start /dev/stdout`, will take a few minutes to boot up, you will recieve a discord notification on server starting, and when the server is ready to connect
- A Cloudwatch alarm is used to auto shutdown the server after 30 minutes of inactivity, a discord notification is sent. For more infomation visit the blog
- To manually stop the server run `aws lambda invoke --function-name ${serverName}-stop /dev/stdout`

- Connect to server using the serverName, searching in the valheim server logs

If however there is a issue, you can connect directly with an IP address.
In AWS, got to : `elastic container service/<serverName>/Tasks/<select first task>/netowrking/PublicIp`

Further work is needed to automatically retrieve the IP address, this will be implemented alongside the discord bot.




