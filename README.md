# dchat_client
A decentralized multiplatform (only web and android tested) chat client using ECDH to transfer message. 

## dchat_server
This client needs to connect the dchat_server to recieve message from others. You can deploy your own server or find some servers exposed by some friendly guys on the internet.If you are interested in the server, see the server repository.


## dchat URI
DChat client use dc uri to locate the user.
Here is an example:
`dc://test@127.0.0.1/BI3OVFLawu59iQtRBtffhQf-4bGtp9oiIm_YzkUNLEH-`

Obviously, It simply consits of the custom scheme "dc", the user name "test", the server "127.0.0.1" and the base64Url-encoded ec publickey point "BI3OVFLawu59iQtRBtffhQf-4bGtp9oiIm_YzkUNLEH-"

You can start a new chat by using this uri in the client, or you can just click the uri and start a safe coversation if this client is installed on your phone(only android tested). 
