extension radius

param environment string

@description('Password/token for the OCI registry the containerImages recipe pushes to.')
@secure()
param registryPassword string

@description('Username for the OCI registry the containerImages recipe pushes to.')
param registryUsername string

resource microservicesDemoApp 'Radius.Core/applications@2025-08-01-preview' = {
  name: 'microservices-demo'
  properties: {
    environment: environment
  }
}

resource redisCache 'Radius.Data/redisCaches@2025-08-01-preview' = {
  name: 'redis'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'kubernetes-manifests/cartservice.yaml#L89'
    size: 'S'
  }
}

resource registryCreds 'Radius.Security/secrets@2025-08-01-preview' = {
  name: 'radius-ghcr-registry-creds'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    data: {
      password: {
        value: registryPassword
      }
      username: {
        #disable-next-line use-secure-value-for-secure-inputs
        value: registryUsername
      }
    }
  }
}

resource adserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'adservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/adservice/Dockerfile#L18'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/adservice?ref=34ffea9175946982c3088ed84994fe6019ad6e92'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource cartserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'cartservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/cartservice/src/Dockerfile#L19'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/cartservice/src?ref=34ffea9175946982c3088ed84994fe6019ad6e92'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource checkoutserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'checkoutservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/checkoutservice/Dockerfile#L18'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/checkoutservice?ref=34ffea9175946982c3088ed84994fe6019ad6e92'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource currencyserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'currencyservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/currencyservice/Dockerfile#L18'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/currencyservice?ref=34ffea9175946982c3088ed84994fe6019ad6e92'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource emailserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'emailservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/emailservice/Dockerfile#L18'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/emailservice?ref=34ffea9175946982c3088ed84994fe6019ad6e92'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource frontendImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'frontend-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/frontend/Dockerfile#L18'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/frontend?ref=34ffea9175946982c3088ed84994fe6019ad6e92'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource loadgeneratorImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'loadgenerator-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/loadgenerator/Dockerfile#L18'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/loadgenerator?ref=34ffea9175946982c3088ed84994fe6019ad6e92'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource paymentserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'paymentservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/paymentservice/Dockerfile#L18'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/paymentservice?ref=34ffea9175946982c3088ed84994fe6019ad6e92'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource productcatalogserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'productcatalogservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/productcatalogservice/Dockerfile#L18'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/productcatalogservice?ref=34ffea9175946982c3088ed84994fe6019ad6e92'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource recommendationserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'recommendationservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/recommendationservice/Dockerfile#L18'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/recommendationservice?ref=34ffea9175946982c3088ed84994fe6019ad6e92'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource shippingserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'shippingservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/shippingservice/Dockerfile#L18'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/shippingservice?ref=34ffea9175946982c3088ed84994fe6019ad6e92'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource adserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'adservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/adservice/src/main/java/hipstershop/AdService.java#L54'
    containers: {
      adservice: {
        image: adserviceImage.properties.imageReference
        env: {
          PORT: {
            value: '9555'
          }
        }
        ports: {
          grpc: {
            containerPort: 9555
          }
        }
      }
    }
  }
}

resource cartserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'cartservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/cartservice/src/Startup.cs#L29'
    containers: {
      cartservice: {
        image: cartserviceImage.properties.imageReference
        env: {
          REDIS_ADDR: {
            value: '${redisCache.properties.host}:${redisCache.properties.port}'
          }
        }
        ports: {
          grpc: {
            containerPort: 7070
          }
        }
      }
    }
  }
}

resource checkoutserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'checkoutservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/checkoutservice/main.go#L110'
    containers: {
      checkoutservice: {
        image: checkoutserviceImage.properties.imageReference
        env: {
          CART_SERVICE_ADDR: {
            value: '${any(cartserviceContainer.properties).hosts['cartservice']}:7070'
          }
          CURRENCY_SERVICE_ADDR: {
            value: '${any(currencyserviceContainer.properties).hosts['currencyservice']}:7000'
          }
          EMAIL_SERVICE_ADDR: {
            value: '${any(emailserviceContainer.properties).hosts['emailservice']}:8080'
          }
          PAYMENT_SERVICE_ADDR: {
            value: '${any(paymentserviceContainer.properties).hosts['paymentservice']}:50051'
          }
          PORT: {
            value: '5050'
          }
          PRODUCT_CATALOG_SERVICE_ADDR: {
            value: '${any(productcatalogserviceContainer.properties).hosts['productcatalogservice']}:3550'
          }
          SHIPPING_SERVICE_ADDR: {
            value: '${any(shippingserviceContainer.properties).hosts['shippingservice']}:50051'
          }
        }
        ports: {
          grpc: {
            containerPort: 5050
          }
        }
      }
    }
  }
}

resource currencyserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'currencyservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/currencyservice/server.js#L83'
    containers: {
      currencyservice: {
        image: currencyserviceImage.properties.imageReference
        env: {
          DISABLE_PROFILER: {
            value: '1'
          }
          PORT: {
            value: '7000'
          }
        }
        ports: {
          grpc: {
            containerPort: 7000
          }
        }
      }
    }
  }
}

resource emailserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'emailservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/emailservice/email_server.py#L129'
    containers: {
      emailservice: {
        image: emailserviceImage.properties.imageReference
        env: {
          DISABLE_PROFILER: {
            value: '1'
          }
          PORT: {
            value: '8080'
          }
        }
        ports: {
          grpc: {
            containerPort: 8080
          }
        }
      }
    }
  }
}

resource frontendContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'frontend'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/frontend/main.go#L127'
    containers: {
      frontend: {
        image: frontendImage.properties.imageReference
        env: {
          AD_SERVICE_ADDR: {
            value: '${any(adserviceContainer.properties).hosts['adservice']}:9555'
          }
          CART_SERVICE_ADDR: {
            value: '${any(cartserviceContainer.properties).hosts['cartservice']}:7070'
          }
          CHECKOUT_SERVICE_ADDR: {
            value: '${any(checkoutserviceContainer.properties).hosts['checkoutservice']}:5050'
          }
          CURRENCY_SERVICE_ADDR: {
            value: '${any(currencyserviceContainer.properties).hosts['currencyservice']}:7000'
          }
          ENABLE_PROFILER: {
            value: '0'
          }
          PORT: {
            value: '8080'
          }
          PRODUCT_CATALOG_SERVICE_ADDR: {
            value: '${any(productcatalogserviceContainer.properties).hosts['productcatalogservice']}:3550'
          }
          RECOMMENDATION_SERVICE_ADDR: {
            value: '${any(recommendationserviceContainer.properties).hosts['recommendationservice']}:8080'
          }
          SHIPPING_SERVICE_ADDR: {
            value: '${any(shippingserviceContainer.properties).hosts['shippingservice']}:50051'
          }
          SHOPPING_ASSISTANT_SERVICE_ADDR: {
            value: 'shoppingassistantservice:80'
          }
        }
        ports: {
          web: {
            containerPort: 8080
          }
        }
      }
    }
  }
}

resource loadgeneratorContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'loadgenerator'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/loadgenerator/locustfile.py#L17'
    containers: {
      frontendCheck: {
        initContainer: true
        image: 'busybox:1.38.0@sha256:fd8d9aa63ba2f0982b5304e1ee8d3b90a210bc1ffb5314d980eb6962f1a9715d'
        command: [
          '/bin/sh'
          '-exc'
        ]
        args: [
          'until wget -q -O /dev/null "http://$FRONTEND_ADDR/"; do sleep 10; done'
        ]
        env: {
          FRONTEND_ADDR: {
            value: '${any(frontendContainer.properties).hosts['frontend']}:8080'
          }
        }
      }
      loadgenerator: {
        image: loadgeneratorImage.properties.imageReference
        env: {
          FRONTEND_ADDR: {
            value: '${any(frontendContainer.properties).hosts['frontend']}:8080'
          }
          RATE: {
            value: '1'
          }
          USERS: {
            value: '10'
          }
        }
      }
    }
    restartPolicy: 'Always'
  }
}

resource paymentserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'paymentservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/paymentservice/index.js#L67'
    containers: {
      paymentservice: {
        image: paymentserviceImage.properties.imageReference
        env: {
          DISABLE_PROFILER: {
            value: '1'
          }
          PORT: {
            value: '50051'
          }
        }
        ports: {
          grpc: {
            containerPort: 50051
          }
        }
      }
    }
  }
}

resource productcatalogserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'productcatalogservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/productcatalogservice/server.go#L115'
    containers: {
      productcatalogservice: {
        image: productcatalogserviceImage.properties.imageReference
        env: {
          DISABLE_PROFILER: {
            value: '1'
          }
          PORT: {
            value: '3550'
          }
        }
        ports: {
          grpc: {
            containerPort: 3550
          }
        }
      }
    }
  }
}

resource recommendationserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'recommendationservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/recommendationservice/recommendation_server.py#L130'
    containers: {
      recommendationservice: {
        image: recommendationserviceImage.properties.imageReference
        env: {
          DISABLE_PROFILER: {
            value: '1'
          }
          PORT: {
            value: '8080'
          }
          PRODUCT_CATALOG_SERVICE_ADDR: {
            value: '${any(productcatalogserviceContainer.properties).hosts['productcatalogservice']}:3550'
          }
        }
        ports: {
          grpc: {
            containerPort: 8080
          }
        }
      }
    }
  }
}

resource shippingserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'shippingservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/shippingservice/main.go#L73'
    containers: {
      shippingservice: {
        image: shippingserviceImage.properties.imageReference
        env: {
          DISABLE_PROFILER: {
            value: '1'
          }
          PORT: {
            value: '50051'
          }
        }
        ports: {
          grpc: {
            containerPort: 50051
          }
        }
      }
    }
  }
}
