# dchat-client
A decentralized multiplatform (only web and android tested) chat client using ECDH to transfer message. It is a project inspired by blockchain. As we know, we share our blockchain address on the internet, others can transfer decentralized coin through the address. Likewise, in this project, you share your uri on the internet, people can talk to you safely and anonymously through the uri.
## Usage

### User config
 To use this client, a deployed dchat server instance is needed. You can deploy your own server, it's pretty easy by using docker, see [server repository](https://github.com/hegoudai/dchat_server).
### My URI
DChat client use dc uri to locate the user.After completing your user config, you can get your uri by clicking the My URI menu item.
Here is an example:
`dc://hegoudai@47.106.144.145/BN7-lwTfMw09OVweh2-o2LjBAQaO9WinnTmlg1XE3kO8`

Obviously, It simply consits of the custom scheme "dc", the user name "hegoudai", the server "47.106.144.145" and the base64Url-encoded ec publickey point "BN7-lwTfMw09OVweh2-o2LjBAQaO9WinnTmlg1XE3kO8"
### New Chat
You can start a new chat by using this uri in the client, or you can just click the uri and start a safe coversation if this client is installed on your phone(only android tested). 
## Contributing
Pull requests are welcome. 
For major changes, please open an issue first to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)