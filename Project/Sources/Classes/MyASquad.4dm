/*------------------------------------------------------------------------------
Class : cs.MyASquad

Class pour gérer les appels API entre MyASquad et le logiciel Paxtel

------------------------------------------------------------------------------*/
Class constructor
	This:C1470.token:="af924be4ff53e7b2cf0bd53fb376898964ab16f168f"+\
		"1f19e9fd60816a0815da853ecc06b77a3415235db2c0280c6ffcbb23c565359db347cc95e306802d1882a8bfacbbc24b741dc51c"+\
		"4f46d9c3f1b05d34e2132299ed6bc82383c72e37511f4b63239e969661de6f175233a1a8f9f901b57cf25f1ed4389b5ffdb6dd3d"+\
		"18302"
	
Function getEnumeration($enumeration_t : Text)->$response_t : Text
	
	outilsWebHTTPRequest("GET"; "https://paxtel-staging-backend.cleverapps.io/api/"+$enumeration_t+"?pagination[page]=1&pagination[pageSize]=1000&sort[0]=id%3Aasc"; ""; \
		->$response_t; New collection:C1472("Authorization"); New collection:C1472("Bearer "+This:C1470.token))