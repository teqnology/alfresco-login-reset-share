/**
 * Fogot password workflow creation
 *
 * @method POST
 */

function main()
{
   // make remote call to create workflow
   var emailFeedDisabled = true;
   if (json.has("user-notifications-email"))
   {
      emailFeedDisabled = !(json.get("user-notifications-email") == "on");
   }
   var conn = remote.connect("alfresco");
   var result = conn.post(
      "/api/people?filter=",
      jsonUtils.toJSONString(
         {
            "username": user.id,
            "properties":
            {
               "cm:emailFeedDisabled": emailFeedDisabled
            }
         }),
      "application/json");
   if (result.status == 200)
   {
      model.success = true;
   }
   else
   {
      model.success = false;
      status.code = result.status;
   }
}

main();