<cfif form.name>
  <cfoutput>
  <h1>Hello #form.name#!</h1>
  </cfoutput>
<cfelse>
  <h1>Hello there, what's your name?</h1>
  <form action="/greet1.cfm" method="post">
    <input name="name">
  </form>
</cfif>
