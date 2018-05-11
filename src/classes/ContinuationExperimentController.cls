/*
*	Author	:	Sudipta Deb
*	Blog	:	www.sudipta-deb.in
*/
public with sharing class ContinuationExperimentController {
	public String res {get;set;}
	public String resLongRunServ {get;set;}
	public String continuationId;
	public String continuationIdLongRunSrv;

	public String SERVICE_URL	=	'https://my-json-server.typicode.com/suddeb/MyJasonServer/salesforce';
	public String LONG_RUNNING_SERVICE_URL	=	'https://long-running.herokuapp.com/products?latency=6000';
	
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

	public Object callServiceWithLongRunSrv(){
		//Create the callout
		HttpRequest request = new HttpRequest();
		request.setMethod('GET');
		request.setEndpoint(LONG_RUNNING_SERVICE_URL);

		//Create the continuation object
		//Max Timeout allowed in 60 seconds
		Continuation con 		= new Continuation(60);
		//Adding the callBackMethod
		con.continuationMethod 	= 'callBackMethodForLongRunningService';
		continuationIdLongRunSrv = con.addHttpRequest(request); 

		return con;
	}

	public Object callBackMethodForLongRunningService(){
		HttpResponse response = Continuation.getResponse(continuationIdLongRunSrv);
		resLongRunServ = response.getBody();
		return null;
	}

	public Object callBackMethod(){
		HttpResponse response = Continuation.getResponse(continuationId);
		res = response.getBody();
		return null;
	}
}