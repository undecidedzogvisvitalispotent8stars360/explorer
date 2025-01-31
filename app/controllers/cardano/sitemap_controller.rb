class Cardano::SitemapController < NetworkController

  QUERY = BitqueryGraphql::Client.parse <<-'GRAPHQL'
           query ($network: CardanoNetwork! $from: ISO8601DateTime){
             
              receivers: cardano(network: $network ) { 
                  
                      outputs(options:{desc: "value", limit: 100 },
                      date: { since: $from }

                    ) {

                      value
                      currency {
                        symbol
                      }
                      address: outputAddress{
                        address
                      }

                    }

              }

              senders: cardano(network: $network ) { 
                  
                      inputs(options:{desc: "value", limit: 100 },
                      date: { since: $from }

                    ) {

                      value
                      currency {
                        symbol
                      }
                      address: inputAddress{
                        address
                      }

                    }

              }

           }
  GRAPHQL

  def index
    @response = BitqueryGraphql::Client.query(QUERY, variables: { from: Date.today - 14,
                                                                  network: @network[:network] }).data
  rescue Net::ReadTimeout => e
    Raven.capture_exception e
    sleep(1)
    retry
  end
end
