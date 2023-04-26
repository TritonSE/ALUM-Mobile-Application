import express, { NextFunction, Request, Response } from "express";
import mongoose from "mongoose";

const router = express.Router()

// Add Firebase Auth
router.get('/calendly', (req: Request, res: Response) => {
    const calendlyLink = req.query.url;
    const calendlyPage = `
    <html>
    <head>
        <meta name='viewport' content='width=device-width' />
    </head>
    <script>
        function sendMessage() {
            webkit.messageHandlers.myHandler.postMessage("Hello from HTML page!");
            console.log("message sent", window.parent.origin);
            fetch('http://127.0.0.1:5000/')
            .then(response => {
                console.log(response);
            })
            .catch(error => {
                    console.error(error);
            });
        }
        function isCalendlyEvent(e) {
            return e.data.event &&
                e.data.event.indexOf('calendly') === 0;
        };
                        
        window.addEventListener(
            'message',
            function(e) {{
            if (isCalendlyEvent(e)) {
                console.log(e.data);
                }}
            }
        );
                    
        function isCalendlyEvent(e) {
            console.log('testing' + e.name);
            return e.data.event &&
                e.data.event.indexOf('calendly') === 0;
        };
                    
        window.addEventListener('message', function(e) {
            console.log('In listener. Event.type: ' + event.type +
                ' e.data.event: ' + e.data.event + ' event: ' + JSON.stringify(e.data));
            if (isCalendlyEvent(e)) {
                console.log('calendly event!!!!');
                    window.webkit.messageHandlers.myHandler.postMessage('Calendly:' + e.data);
            } else {
                window.webkit.messageHandlers.myHandler.postMessage('Other:' + e.data);
            }
        });
    </script>
    <button onclick="sendMessage()">Send Message </button>
    <!-- Calendly inline widget begin -->
    <div class="calendly-inline-widget" data-auto-load="false">
        <script type="text/javascript" src="https://assets.calendly.com/assets/external/widget.js"></script>
        <script>
            
            Calendly.initInlineWidget({
                url: '${calendlyLink}',
            });
        </script>
    </div>
     <!-- Calendly inline widget end -->
    </html>
    `

    res.render("index", {calendlyPage: calendlyPage})
})

export { router as calendlyPage }