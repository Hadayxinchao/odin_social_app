# ERRORS: google-auth2

 * This note provides information on how to resolve the "redirect_uri_mismatch" error when using google_auth.
 * 
 * The error occurs when google_auth does not accept the "http://localhost:{port}" redirect URI.
 * To resolve this, you need to make your app accessible through a secure link, such as "https://...".
 * 
 * One of my recommended solutions is to create an account in Ngrok (https://ngrok.com/) to expose your local server to the internet.
 * 
 * Additionally, you need to change the "Authorized redirect URIs" on the Google Console Could (https://console.cloud.google.com).

# ERRORS: Active Storage
 * Error details: "LoadError (Could not open library 'vips.so.42': vips.so.42: cannot open shared object file: No such file or directory. Could not open library 'libvips.so.42': libvips.so.42: cannot open shared object file: No such file or directory. Searched in , /usr/lib, /usr/local/lib, /opt/local/lib):"
 * The error message indicates that the system is unable to find the libvips library, which is a dependency for some Ruby gems like image_processing or ruby-vips.
 * try: "sudo apt-get install libvips42"

# DEPLOY APP IN HEROKU
 * https://devcenter.heroku.com/articles/rediscloud
 * https://pragmaticstudio.com/tutorials/using-active-storage-in-rails
 * https://devcenter.heroku.com/articles/getting-started-with-rails7#create-a-welcome-page