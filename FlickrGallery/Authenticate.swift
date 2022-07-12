//
//  Authenticate.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 07/07/2022.
//

import Foundation


/*
 Let’s walkthrough the steps above using my OAuth1.0 implementation. First, we have Step 1 (Request Token):
 */
/*
 func requestOAuthToken(args: RequestOAuthTokenInput,_ complete: @escaping (RequestOAuthTokenResponse) -> Void) {
         let request = (url: FlickrAPI.requestTokenURL, httpMethod: "POST")
         let callback = args.callbackScheme + "://success"
         
         var params: [String: Any] = [
             "oauth_callback" : callback,
             "oauth_consumer_key" : args.consumerKey,
             "oauth_nonce" : UUID().uuidString, // nonce can be any 32-bit string made up of random ASCII values
             "oauth_signature_method" : "HMAC-SHA1",
             "oauth_timestamp" : String(Int(NSDate().timeIntervalSince1970)),
             "oauth_version" : "1.0"
         ]
         // Build the OAuth Signature from Parameters
         params["oauth_signature"] = oauthSignature(httpMethod: request.httpMethod, url: request.url, params: params, consumerSecret: args.consumerSecret)
         
         // Once OAuth Signature is included in our parameters, build the authorization header
         let authHeader = authorizationHeader(params: params)
         
         guard let url = URL(string: request.url) else { return }
         var urlRequest = URLRequest(url: url)
         urlRequest.httpMethod = request.httpMethod
         urlRequest.setValue(authHeader, forHTTPHeaderField: "Authorization")
         let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
             guard let data = data else { return }
             guard let dataString = String(data: data, encoding: .utf8) else { return }
             // dataString should return: oauth_token=XXXX&oauth_token_secret=YYYY&oauth_callback_confirmed=true
             let attributes = dataString.urlQueryStringParameters
             let result = RequestOAuthTokenResponse(oauthToken: attributes["oauth_token"] ?? "",
                                                    oauthTokenSecret: attributes["oauth_token_secret"] ?? "",
                                                    oauthCallbackConfirmed: attributes["oauth_callback_confirmed"] ?? "")
             complete(result)
         }
         task.resume()
     }
 */

/*
 Now Steps 1 through 3 together:

 */
/*
 let oAuthTokenInput = RequestOAuthTokenInput(consumerKey: FLICKR_CONSUMER_KEY,
                                              consumerSecret: FLICKR_CONSUMER_SECRET,
                                              callbackScheme: FLICKR_URL_SCHEME)
 requestOAuthToken(args: oAuthTokenInput) { oAuthTokenResponse in
     // Kick off our Step 2 observer: start listening for user login callback in scene delegate (from handleOpenUrl)
     self.callbackObserver = NotificationCenter.default.addObserver(forName: .flickrCallback, object: nil, queue: .main) { notification in
         self.callbackObserver = nil // remove notification observer
         self.showSheet = false      // hide sheet containing safari view
         self.authUrl = nil          // remove safari view
         guard let url = notification.object as? URL else { return }
         guard let parameters = url.query?.urlQueryStringParameters else { return }
         /*
          url => flickrsdk://success?oauth_token=XXXX&oauth_verifier=ZZZZ
          url.query => oauth_token=XXXX&oauth_verifier=ZZZZ
          url.query?.urlQueryStringParameters => ["oauth_token": "XXXX", "oauth_verifier": "YYYY"]
          */
         guard let verifier = parameters["oauth_verifier"] else { return }
         
         // Start Step 3: Request Access Token
         let accessTokenInput = RequestAccessTokenInput(consumerKey: FLICKR_CONSUMER_KEY,
                                                        consumerSecret: FLICKR_CONSUMER_SECRET,
                                                        requestToken: oAuthTokenResponse.oauthToken,
                                                        requestTokenSecret: oAuthTokenResponse.oauthTokenSecret,
                                                        oauthVerifier: verifier)
         self.requestAccessToken(args: accessTokenInput) { accessTokenResponse in
             // Process Completed Successfully!
             DispatchQueue.main.async {
                 self.credential = accessTokenResponse
                 self.authUrl = nil
                 keychain["flickrAccessToken"] = self.credential?.accessToken
                 keychain["flickrAccessTokenSecret"] = self.credential?.accessTokenSecret
                 keychain["flickrUserID"] = self.credential?.userId
                 keychain["flickrScreenName"] = self.credential?.screenName
                 
                 self.oauthClient = self.createOAuthClient(args: FlickrOAuthClientInput(consumerKey: FLICKR_CONSUMER_KEY,
                                                                                        consumerSecret: FLICKR_CONSUMER_SECRET,
                                                                                        accessToken: self.credential!.accessToken,
                                                                                        accessTokenSecret: self.credential!.accessTokenSecret))
             }
         }
         
         self.authenticationState = .successfullyAuthenticated
     }
     
     // Start Step 2: User Flickr Login
     let urlString = "\(FlickrAPI.authorizeURL)?oauth_token=\(oAuthTokenResponse.oauthToken)&perms=write"
     guard let oauthUrl = URL(string: urlString) else { return }
     DispatchQueue.main.async {
         self.authUrl = oauthUrl // sets our safari view url
     }
 }
 */
/*
The reader can find the complete FlickrOAuthService.swift file in the GitHub repository at the end of the article.
I also developed an authentication state model to use with the ViewModel:
*/
