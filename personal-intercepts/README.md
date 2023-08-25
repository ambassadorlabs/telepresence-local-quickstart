## Personal Intercept setup

This directory contains resources for doing a demo of personal intercepts using the Baggage header and OpenTelemetry K8s Operator to propagate it.

You'll need a browser extension that allows you to set custom headers, so you can set the header `devid` to `123456`.
For the demo, have a browser window open that is using that header, and one that is not. Show how when you visit http://verylargejavaservice.default:8080
without an intercept happening, the default is green, just like the global intercepts demo. Then run the script `personal-intercepts.sh` which will
install the OTel K8s Operator, and amend the `verylargejavaservice` and `dataprocessingservice` to request an OTel instrumentation injection.
Now show how when you refresh in the browser window that adds the header, it changes to blue. Do the code change to orange like the
global intercepts demo. Now pull out your browser window that does _not_ add the header and refresh, and show that all other requests still go
to the original deployment and still show green.

Mention Preview URLs (and maybe pull some archival footage from another demo?) but I don't think we need to set up a whole thing to show them off;
this keeps the video snappy as well.
