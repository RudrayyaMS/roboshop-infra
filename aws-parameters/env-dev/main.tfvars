parameters = [
  ##frontend service
  { name= "dev.frontend.catalogue_url" , value = "http://catalogue-dev.devopsm71.online:8080/" , type= "String"},
  { name= "dev.frontend.user_url" ,      value = "http://user-dev.devopsm71.online:8080/" , type= "String"},
  { name= "dev.frontend.cart_url" ,      value = "http://cart-dev.devopsm71.online:8080/" , type= "String"},
  { name= "dev.frontend.shipping_url" ,  value = "http://shipping-dev.devopsm71.online:8080/" , type= "String"},
  { name= "dev.frontend.payment_url" ,   value = "http://payment-dev.devopsm71.online:8080/" , type= "String"},
  ##user service
  { name= "dev.user.mongo" ,             value = "true" , type= "String"},
  { name= "dev.user.redis_host" ,   value = "redis-dev.devopsm71.online" , type= "String"},
  { name= "dev.user.mongo_url" ,   value = "mongodb://mongodb-dev.devopsm71.online:27017/users" , type= "String"},
  ## shipping service
  { name= "dev.shipping.cart_endpoint" ,   value = "cart-dev.devopsm71.online:8080" , type= "String"},
  { name= "dev.shipping.db_host" ,   value = "mysql-dev.devopsm71.online" , type= "String"},
  ##payment service
  { name= "dev.payment.cart_host" , value = "cart-dev.devopsm71.online" , type= "String"},
  { name= "dev.payment.cart_port" , value = "8080" , type= "String"},
  { name= "dev.payment.user_host" , value = "user-dev.devopsm71.online" , type= "String"},
  { name= "dev.payment.user_port" , value = "8080" , type= "String"},
  { name= "dev.payment.amqp_host" , value = "rabbitmq-dev.devopsm71.online" , type= "String"},
  ##catalogue service
  { name= "dev.catalogue.mongo" , value = "true" , type= "String"},
  { name= "dev.catalogue.mongo_url" , value = "mongodb://mongodb-dev.devopsm71.online:27017/catalogue" , type= "String"},
  ##cart service
  { name= "dev.cart.redis_host" , value = "redis-dev.devopsm71.online" , type= "String"},
  { name= "dev.cart.catalogue_host" , value = "catalogue-dev.devopsm71.online" , type= "String"},
  { name= "dev.cart.catalogue_port" , value = "8080" , type= "String"}
]


## This is not going to be practice in companies , we should not keep passwords in git repo
secrets = [
  { name= "dev.mysql.password" , value = "Roboshop@1" , type= "SecureString"},
  { name= "dev.payment.amqp_user" , value = "roboshop" , type= "SecureString"},
  { name= "dev.payment.amqp_pass" , value = "roboshop123" , type= "SecureString"},
  { name= "dev.rabbitmq.amqp_user" , value = "roboshop" , type= "SecureString"},
  { name= "dev.rabbitmq.amqp_pass" , value = "roboshop123" , type= "SecureString"}
  # tf-module-docdb secrets
  { name= "dev.docdb.user" , value = "admin1" , type= "SecureString"},
  { name= "dev.docdb.pass" , value = "RoboShop1" , type= "SecureString"}
]



