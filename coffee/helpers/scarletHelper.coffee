module.exports =
	authenticateUser: (userId,authToken,app,directive) ->
		if typeof(userId) != 'undefined'
			app.db.User.find
				where:
					id: userId
			.success (user) ->
				if user == null
					directive "Server Null User"
				else
					if user.authToken == authToken
						directive "Affirmative"
					else 
						directive "Token Mismatch"
		else
			directive "Client Null User"