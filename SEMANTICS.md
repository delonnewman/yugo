Semantic Map
============

`cfif`, `cfelse`, `cfelseif`
---------------------------

Ruby `if`, `else`, `elsif`

`cfloop` (index loop)
---------------------

### Attributes

`index` (Required)
`from` (Required)
`to` (Required)
`step` (Optional, defaults to `1`)
`charset` (Optional, charset to use when reading in a file line-by-line)

Can loop over date / time ranges (see https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-j-l/cfloop-looping-over-a-date-or-time-range.html)

### Examples

```coldfusion
<cfloop index="i" from="1" to="5" >
    The loop index is <cfoutput>#i#</cfoutput>.
</cfloop>
```

```coldfusion
<cfset j=5/>
<cfloop index = "LoopCount" from = "1" to = #j#> 
    <cfoutput>The loop index is #LoopCount#</cfoutput>.
    <cfset j = j - 1> 
</cfloop>
```

```coldfusion
<cfloop index = "LoopCount"
        from = "5"
        to = "1"
        step = "-1"> 
    The loop index is <cfoutput>#LoopCount#</cfoutput>.
</cfloop>
```

`cfloop` (conditional loop)
---------------------------

Ruby `while`

### Attributes

`condition` (Required)

### Examples

```coldfusion
<!--- Set the variable CountVar to 0. --->
<cfset CountVar = 0> 
<!--- Loop until CountVar = 5. --->
<cfloop condition = "CountVar LESS THAN 5"> 
<cfset CountVar = CountVar + 1> 
    The loop index is <cfoutput>#CountVar#</cfoutput>. 
</cfloop>
```

`cfloop` (looping over a query)
-------------------------------

(see https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-j-l/cfloop-looping-over-a-query.html)

### Attributes

`query` (Required)
`startRow` (Optional)
`endRow` (Optional)
`group` (Optional)

### Examples

```coldfusion
<cfscript>
    myQuery = queryNew("id,name,amount","Integer,Varchar,Integer",
                [
                        {id=1,name="One",amount=15},
                        {id=2,name="Two",amount=18},
                        {id=3,name="Three",amount=32}
                ]);
</cfscript>
<cfloop query = "myQuery">
    <cfoutput>#id#.#name#</cfoutput>
</cfloop>
```

```coldfusion
<cfscript>
    myQuery = queryNew("id,name,amount","Integer,Varchar,Integer",
                [
                        {id=1,name="One",amount=15},
                        {id=2,name="Two",amount=18},
                        {id=3,name="Three",amount=32},
                        {id=4,name="Four",amount=37},
                        {id=5,name="Five",amount=79},
                        {id=6,name="Six",amount=26}
                ]);
</cfscript>
<cfset Start = 3>
<cfset End = 6>
<cfloop query = "myQuery"
        startRow = "#Start#"
        endRow = "#End#">
    <cfoutput>#name# #amount#</cfoutput>
</cfloop>
```

```coldfusion
<cfquery name = "GetTemplate" dataSource = "Library" maxRows = "5">
    SELECT TemplateName
    FROM Templates
</cfquery>
<cfloop query = "GetTemplate">
    <cfinclude template = "#TemplateName#">
</cfloop>
```

```coldfusion
<cfquery name = "result" datasource="cfcodeexplorer">
 SELECT ORDERID, CUSTOMERFIRSTNAME,STATE,CITY
 FROM ORDERS
 ORDER BY CITY
</cfquery>
 
<cfoutput query="result" group="CITY">
    #result.CITY#
</cfoutput>
```

`cfloop` (looping over a COM collection or structure)
-----------------------------------------------------

### Examples

```coldfusion
<cfscript>
departments = structNew("Ordered");
 /** On iterating this struct, you get the values in insertion order, which is the way you inserted the values. **/
 /** Create a structure and set its contents. **/
       
     departments.John = "Sales";
     departments.Tom = "Finance";
     departments.Mike = "Education";
     departments.Andrew = "Marketing";
       
 /** Build a table to display the contents **/
       
</cfscript>
<cfoutput >
<table cellpadding="2" cellspacing="2">
    <tr>
        <td><b>Employee</b></td>
        <td><b>Department</b></td>
    </tr>
<!--- Use cfloop to loop through the departments structure.The item attribute specifies a name for the structure key. --->
   <cfloop collection=#departments# item="person">
        <tr>
            <td>#person#</td>
            <td>#Departments[person]#</td>
        </tr>
    </cfloop>
</table>
</cfoutput>
```
