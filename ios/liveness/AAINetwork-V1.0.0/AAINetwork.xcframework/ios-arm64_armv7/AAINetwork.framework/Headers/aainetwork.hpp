//
//  aainetwork.hpp
//  AAINetwork
//
//  Created by advance on 2022/8/11.
//

#ifndef aainetwork_hpp
#define aainetwork_hpp

#include<string>
#include <map>

namespace aai
{
    namespace network
    {
        class Request
        {
        public:
            enum ResponseCheck {
                HttpCode200, Json,
            };
            
            Request();
            ~Request();
            Request(const Request &obj);
            
            void setHTTPMethod(const std::string &method);
            void setContentType(const std::string &contentType);
            void setRequestUrl(const std::string &url);
            void setHTTPHeader(const std::string name, const std::string value);
            void setHTTPBody(const std::string &body);
            void setTimeoutInterval(int timeoutIntervalInseconds);
            void setTag(const std::string tag);
            void setResponseCheck(ResponseCheck rc);
            
            class Impl;
            Impl* getImpl() const;
        private:
            std::unique_ptr<Impl> pImpl;
        };

        class Response
        {
        public:
            Response();
            ~Response();
            
            std::map<std::string, std::string> headers;
            std::string responseBody;
            bool isResponseValid;
        };

        class HTTPSession
        {
        public:
            HTTPSession();
            ~HTTPSession();

            static HTTPSession& defaultSession();
            Response sendRequest(const Request &request);

        private:
            class Impl;
            std::unique_ptr<Impl> pImpl;
        };
        
        
        void aes(const std::string &key, uint8_t *data, size_t len);
        
        std::string base64Encode(const std::string &s);
        void base64Decode(const std::string &s, std::string &ret);
    
        static const std::string moduleVersion = "1.0.0";
    };
};


#endif /* aainetwork_hpp */
