
Andro Custom Login Share
---

# Essentials 

- Alfresco Share 4.2+
- Alfresco Maven Version 1.1.1
- Alfresco Explorer reset-password web script

# Quickstart

- Open the terminal and run ` mvn integration-test -Pamp-to-war -Dmaven.tomcat.port=8081`. This will setup the SDK and the Alfresco Share on port 8081 (not Alfresco Repository or Solr).
- Wait for the startup of the webapp and then go http://localhost:8081/share. NOTE: For this to work you need to have an Alfresco previously running on port 8080, for example as provided by the Alfresco AMP archetype.
- Import the project in your favorite IDE (with Maven integration) and start developing right away.

# Components

## Alfresco Explorer Web Script

The web script can be reached here: `/andro/base/reset-password`. It's a POST web script, based on `share-extras-reset-password` extension.
The main change is the function that checks if the input is an email or username, and if multiple users are found with same email, prompts with the list of users to chose from.

- `reset-password.post.config.xml`

		<reset-user-password>
		<pw-length>8</pw-length>
		<pw-chars>
		0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz
		</pw-chars>
		<disallowed-users>admin</disallowed-users>
		<log-resets>true</log-resets>
		</reset-user-password>

- `reset-password.post.desc.xml`

		<webscript>
		<shortname>Reset User Password</shortname>
		<description>
		Reset a user's password and send an e-mail confirmation
		</description>
		<url>/andro/base/reset-password</url>
		<authentication runas="admin">none</authentication>
		<format default="json">extension</format>
		<transaction>required</transaction>
		</webscript>

- `reset-password.post.json.ftl`

		<#escape x as jsonUtils.encodeJSONString(x)>
		{
		   "success": ${result?string},
		   "message": "${message}"
		}
		</#escape>

- `reset-password.post.json.js`

        /**
         * Reset User Password script
         * 
         * @method POST
         * @param json {string}
         *    {
         *       email: "email"
         *    }
         */
        model.result = false;
        model.message = "";
        var s = new XML(config.script);
        
        function getRandomNum(lbound, ubound)
        {
           return (Math.floor(Math.random() * (ubound - lbound)) + lbound);
        }
        function getRandomChar()
        {
           var chars = s["pw-chars"].toString();
           return chars.charAt(getRandomNum(0, chars.length));
        }
        function getRandomPassword(n)
        {
           var password = "";
           for (var i=0; i<n; i++)
           {
              password += getRandomChar();
           }
           return password;
        }
        function resetPassword(u)
        {
           var pwlen = parseInt(s["pw-length"].toString(), 10);
           // Auto-generate a password if not specified
           if (u.password == null || u.password == "")
           {
              u.password = getRandomPassword(pwlen);
           }
           var uToken = getUserByUserName(u.userName);
           uToken.properties["companyfax"] = u.password;
           uToken.save();
              //people.setPassword(u.userName, u.password);
           return u;
        }
        function mailResetPasswordNotification(u)
        {
           var logContent = "";
           logContent += (u.email + ", " + u.password + ", " + u.userName + "\n");
           var d = new Date();
           var logFile = companyhome.createFile("reset_password_" + d.getTime() + ".csv");
           logFile.content = logContent;
           logFile.save();
           //return logFile;
           // create mail action
           var mail = actions.create("mail");
           var fromName = person.properties.firstName + " " + person.properties.lastName;
           mail.parameters.to = u.email;
           mail.parameters.from = "admin@alfresco.com"
           mail.parameters.subject = "Alfresco Password Reset";
           var map = new Object();
           map["hostname"] = u.hostname;
           map["username"] = u.userName;
           map["password"] = u.password;
           map["firstname"] = u.firstName;
           map["fromname"] = fromName;
           map["email"] = u.email;
           map["mailtitle"] = "Alfresco Password Reset";
           mail.parameters.template_model = map;   
           mail.parameters.template = companyhome.childByNamePath("Data Dictionary/Email Templates/andro-email-template/reset-password-email.ftl");
           //mail.parameters.text = "Hello " + u.firstName+ ", You requested your password for your account to be reset. You can now log in to Alfresco with the following details. Username: " + u.userName + " - Password (please change after first login): " + u.password + "    If you did not request your password to be reset, you can normally ignore this email. Regards," + fromName;
           // execute action against a space
           mail.execute(companyhome);
           return mail;
        }
        function logResetPasswordResults(users)
        {
           var logContent = "";
           for (var i=0; i<users.length; i++)
           {
              logContent += (users[i].userName + "," + users[i].password + "\n");
           }
           var d = new Date();
           var logFile = userhome.createFile("reset_password_" + d.getTime() + ".csv");
           logFile.content = logContent;
           logFile.save();
           return logFile;
        }
        function userToObject(u)
        {
           return {
              "hostname" : s["hostname"].toString(),
              "firstName" : u.properties.firstName,
              "lastName" : u.properties.lastName,
              "email" : u.properties.email.toLowerCase(),
              "userName" : u.properties.userName,
              "password" : null
           };
        }
        function getUserByUserName(username)
        {
           var uName = people.getPerson(username);
           return uName;
        }
        function getUsersByEmail(email)
        {
           var filter = "email:" + email,
              maxResults = 10,
              peopleCollection = people.getPeople(filter, maxResults);
           return peopleCollection;
        }
        
        function userIsMember(u, g)
        {
           var members = people.getMembers(g);
           for (var i=0; i<members.length; i++)
           {
              if (members[i].properties.userName == u.properties.userName)
              {
                 return true;
              }
           }
           return false;
        }
        function main()
        {
           var user, u, email, users, 
              logResults = s["log-resets"].toString() == "true", 
              disallowedUsers = s["disallowed-users"].toString().split(",");
           
           if ((json.isNull("email")) || (json.get("email") == null) || (json.get("email").length() == 0)) 
           {
              status.setCode(status.STATUS_BAD_REQUEST, "No email or username found");
              status.redirect = true;
              return;
           }
           
           email = json.get("email");
        
           if (email.indexOf("@") > -1){
              users = getUsersByEmail(email);
        
              if (users.length == 0) 
              {
                 status.setCode(status.STATUS_NOT_FOUND, "No user found");
                 status.redirect = true;
                 return;
              }
        
              if (users.length > 1) 
              {
                 var usersArray = [];
                 for ( var i = 0; i < users.length; i++) {
                    user = search.findNode(users[i]);
                    usersArray.push(user.properties.userName);
                 }
                 status.setCode(status.STATUS_BAD_REQUEST, "Multiple users found. Please try to use one of the following: " + usersArray.toString());
                 status.redirect = true;
                 return;
              }
              user = search.findNode(users[0]);
        
           }else{
              user = getUserByUserName(email);
           }
           
           if (user == undefined || user == null){
              status.setCode(status.STATUS_BAD_REQUEST, "The account " + email + " was not found.");
              status.redirect = true;
              return;
           }
           if (!people.isAccountEnabled(user.properties.userName))
           {
              status.setCode(status.STATUS_FORBIDDEN, "This account seems to be disabled. Please contact your system administrator");
              status.redirect = true;
              return;
           }
           
           for ( var i = 0; i < disallowedUsers.length; i++)
           {
              if (user.properties.userName == disallowedUsers[i])
              {
                 status.setCode(status.STATUS_FORBIDDEN, "This account can't use this feature. Please contact your system administrator");
                 status.redirect = true;
                 return;
              }
           }
           
           // Reset the password
           try
           {
              u = resetPassword(userToObject(user));
           }
           catch (e)
           {
              status.setCode(status.STATUS_BAD_REQUEST, "STATUS_BAD_REQUEST");
              status.redirect = true;
              return;
           }
           
           // Send e-mail confirmation
           try
           {
              mailResetPasswordNotification(u);
           }
           catch (e)
           {
              status.setCode(status.STATUS_INTERNAL_SERVER_ERROR, "The email with the new password was not sent. Please retry or contact your system administrator");
              status.redirect = true;
              return;
           }
           
           model.success = true;
           model.result = true;
           
           if (logResults)
           {
              model.resultsLog = logResetPasswordResults([u]);
           }
        }
        
        main();


## Alfresco Share custom login extension

This is a completely new page, based on `materializecss` project (currently Alpha 0.92), with login.js controller.
The controller calls a public web script:

	function getServer() {
	    var srv = remote.call("/api/server")
	    if (srv.status == 200) {
	      srvObj = eval("(" + srv + ")");
	      model.srv = srvObj;
	    }
	}

and injects `model.srv` data into the html login page.

`login.ftl` has an ajax call that calls the `reset-password` web script through `share/proxy/alfresco-noauth` URL:

	$( "#resetP" ).submit(function( event ) {
	                event.preventDefault();
	                var emailF = $('#emailForgotten').val();
	                $.ajax({
	                   type: "POST",
	                   url: "/share/proxy/alfresco-noauth/andro/base/reset-password",
	                   data: JSON.stringify({ email: emailF }),
	                   contentType: "application/json; charset=utf-8",
	                   dataType: "json",
	                   success: function(result) {
	                        $('#formResultP').text("Check your email.");
	                        $('#formResultH').text("Password reset - Success");
	                        $('#resetP').remove();
	                   },
	                   error: function(xhr, status, error) {
	                      var err = eval("(" + xhr.responseText + ")");
	                        $('#formResultP').text(err.message + ", please reload this page.");
	                        $('#formResultH').text("Password reset - Failure");
	                        $('#resetP').remove();
	                    }
	                });
	            });

In order to override the default login page `share-config-custom.xml` needs the following:

	<alfresco-config>
	   <config evaluator="string-compare" condition="WebFramework">
	      <web-framework>
	         <defaults>
	            <page-type>
	               <id>login</id>
	               <page-instance-id>andro-login</page-instance-id>
	            </page-type>
	         </defaults>
	      </web-framework>
	   </config>
	</alfresco-config>

## Alfresco Share reset-password extension

The extension works in the following, simplifed way:

- User enters the email (or the username) of the account to reset the password for.
- The system performs a number of tests to check the email (if one or multiple, if the username exists and if not disabled) then sends and email using the andro template ftl file from the repository.
- The password is still the old one (so if the user ignores the email it will not trigger the reset password feature) but a token has been generated and saved into the `person` object in the repository.
- The user clicks on the link in the email and is prompted with a form with two inputs: 'new password' and 'repeat new password'.
- The page saves in two javascript objects the `token` and the `username` from the url arguments
- Once the form is submitted, the system checks if the saved token matches the one saved in the person object (obtained through the username saved earlier).
- If the token and the username are the ones expected, the new password is being saved.

> Written with [StackEdit](https://stackedit.io/).