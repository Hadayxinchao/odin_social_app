# FILEPATH: /home/hoangha/Documents/repos/local_rails_projects/odinsocial/NOTE.md

 * This note provides information on how to resolve the "redirect_uri_mismatch" error when using google_auth.
 * 
 * The error occurs when google_auth does not accept the "http://localhost:{port}" redirect URI.
 * To resolve this, you need to make your app accessible through a secure link, such as "https://...".
 * 
 * One of my recommended solutions is to create an account in Ngrok (https://ngrok.com/) to expose your local server to the internet.
 * 
 * Additionally, you need to change the "Authorized redirect URIs" on the Google Console Could (https://console.cloud.google.com).

