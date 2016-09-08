class User < ActiveRecord::Base
  has_secure_password
  #セキュアなパスワードの実装のためのメソッド
  #また　authenticateメソッドが使えるようになる
  #(引数の文字列がパスワードと一致するとUserオブジェクトを、間違っているとfalse返すメソッド)。
end
