module Kucoin
  module Rest
    module Private
      module Balances
        
        def wallet_records(coin, type: :deposit, status: :finished, limit: nil, page: nil, options: {})
          options.merge!(authenticate: true)
          
          type      =   type.to_s.upcase
          status    =   status.to_s.upcase
          
          params    =   {type: type, status: status, limit: limit, page: page, coin: coin}
          params.delete_if { |key, value| value.nil? }
          puts 'got here'
          get("/account/wallet/records", params: params, options: options)&.fetch("data", {})
        end
        
        def coin_balance(coin, options: {})
          options.merge!(authenticate: true)          
          
          response  =   get("/account/#{coin}/balance", options: options)&.fetch("data", {})
          ::Kucoin::Models::Balance.new(response) if response
        end
        
        def balance(options: {})
          options.merge!(authenticate: true)          
          response  =   get("/account/balance", options: options)&.fetch("data", {})
          ::Kucoin::Models::Balance.parse(response) if response
        end
      
      end
    end
  end
end
