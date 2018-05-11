/*
*	Author	:	Sudipta Deb
*	Blog	:	www.sudipta-deb.in
*/
public with sharing class ContinuationExperimentController {
	public String res {get;set;}
	public String continuationId;

	public String SERVICE_URL	=	'https://my-json-server.typicode.com/suddeb/MyJasonServer/salesforce';
	
	public Object callService(){
		//Create the callout
		HttpRequest request = new HttpRequest();
		request.setMethod('GET');
		request.setEndpoint(SERVICE_URL);

		//Create the continuation object
		//Max Timeout allowed in 60 seconds
		Continuation con 		= new Continuation(60);
		//Adding the callBackMethod
		con.continuationMethod 	= 'callBackMethod';
		continuationId 			= con.addHttpRequest(request); 

		return con;
	}

	public Object callBackMethod(){
		HttpResponse response = Continuation.getResponse(continuationId);
		res = response.getBody();
		return null;
	}
}