# dchat_client
A decentralized multiplatform (only web and android tested) chat client using ECDH to transfer message. To use this client, a deployed dchat server instance is needed. If you are interested in the server, see [server repository](https://github.com/hegoudai/dchat_server).


## dchat URI
DChat client use dc uri to locate the user.
Here is an example:
`dc://test@127.0.0.1/BI3OVFLawu59iQtRBtffhQf-4bGtp9oiIm_YzkUNLEH-`

Obviously, It simply consits of the custom scheme "dc", the user name "test", the server "127.0.0.1" and the base64Url-encoded ec publickey point "BI3OVFLawu59iQtRBtffhQf-4bGtp9oiIm_YzkUNLEH-"

You can start a new chat by using this uri in the client, or you can just click the uri and start a safe coversation if this client is installed on your phone(only android tested). 
