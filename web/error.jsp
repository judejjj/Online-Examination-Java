<%@ page isErrorPage="true" %>
<h2>Something went wrong!</h2>
<p>Error Message: <%= exception.getMessage() %></p>
<p>Stack Trace:</p>
<pre>
<% exception.printStackTrace(new java.io.PrintWriter(out)); %>
</pre>
