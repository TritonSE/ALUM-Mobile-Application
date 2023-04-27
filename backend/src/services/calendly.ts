import { ServiceError } from "../errors";

/**
 * This function retrieves information about a calendly event
 * via the get route on the calendly API
 */

async function getCalendlyEventDate(uri: String, accessToken: String) {

    const regex = /\/scheduled_events\/(\w+-\w+-\w+-\w+-\w+)/;
    const match = uri.match(regex);

    let uuid = ''
    if (match) {
        uuid = match[1];
        console.log(uuid);
    } else {
        throw ServiceError.INVALID_URI;
    }

    try {
        const response = await fetch(`https://api.calendly.com/scheduled_events/${uuid}`, {
            method: 'GET',
            headers: {
                'Authorization': `Bearer ${accessToken}`,
                'Content-Type': 'application/json'
            }
        });
        const data = response.json();
        const dateTime = data.then(data => data.resource.start_time);
        console.log(dateTime);
        return dateTime
    } catch (e) {
        console.log(e)
        throw ServiceError.ERROR_GETTING_EVENT_DATA
    }

}

export {getCalendlyEventDate}
