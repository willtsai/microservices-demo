extension radius

param environment string
@secure()
param registryPassword string

@secure()
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
    codeReference: 'src/cartservice/src/Startup.cs#L29'
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
    tag: '3870470e'
    codeReference: 'src/adservice/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/adservice?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
        'linux/arm64'
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
    tag: '3870470e'
    codeReference: 'src/cartservice/src/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/cartservice/src?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
        'linux/arm64'
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
    tag: '3870470e'
    codeReference: 'src/checkoutservice/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/checkoutservice?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
        'linux/arm64'
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
    tag: '3870470e'
    codeReference: 'src/currencyservice/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/currencyservice?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
        'linux/arm64'
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
    tag: '3870470e'
    codeReference: 'src/emailservice/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/emailservice?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
        'linux/arm64'
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
    tag: '3870470e'
    codeReference: 'src/frontend/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/frontend?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
        'linux/arm64'
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
    tag: '3870470e'
    codeReference: 'src/loadgenerator/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/loadgenerator?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
        'linux/arm64'
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
    tag: '3870470e'
    codeReference: 'src/paymentservice/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/paymentservice?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
        'linux/arm64'
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
    tag: '3870470e'
    codeReference: 'src/productcatalogservice/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/productcatalogservice?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
        'linux/arm64'
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
    tag: '3870470e'
    codeReference: 'src/recommendationservice/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/recommendationservice?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
        'linux/arm64'
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
    tag: '3870470e'
    codeReference: 'src/shippingservice/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/shippingservice?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
        'linux/arm64'
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
    codeReference: 'src/adservice/Dockerfile'
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
    codeReference: 'src/cartservice/src/Dockerfile'
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
    connections: {
      rediscache: {
        source: redisCache.id
      }
    }
  }
}

resource checkoutserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'checkoutservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/checkoutservice/Dockerfile'
    containers: {
      checkoutservice: {
        image: checkoutserviceImage.properties.imageReference
        env: {
          CART_SERVICE_ADDR: {
            value: 'cartservice-cartservice:7070'
          }
          CURRENCY_SERVICE_ADDR: {
            value: 'currencyservice-currencyservice:7000'
          }
          EMAIL_SERVICE_ADDR: {
            value: 'emailservice-emailservice:8080'
          }
          PAYMENT_SERVICE_ADDR: {
            value: 'paymentservice-paymentservice:50051'
          }
          PORT: {
            value: '5050'
          }
          PRODUCT_CATALOG_SERVICE_ADDR: {
            value: 'productcatalogservice-productcatalogservice:3550'
          }
          SHIPPING_SERVICE_ADDR: {
            value: 'shippingservice-shippingservice:50051'
          }
        }
        ports: {
          grpc: {
            containerPort: 5050
          }
        }
      }
    }
    connections: {
      cartservice: {
        source: cartserviceContainer.id
        disableDefaultEnvVars: true
      }
      currencyservice: {
        source: currencyserviceContainer.id
        disableDefaultEnvVars: true
      }
      emailservice: {
        source: emailserviceContainer.id
        disableDefaultEnvVars: true
      }
      paymentservice: {
        source: paymentserviceContainer.id
        disableDefaultEnvVars: true
      }
      productcatalogservice: {
        source: productcatalogserviceContainer.id
        disableDefaultEnvVars: true
      }
      shippingservice: {
        source: shippingserviceContainer.id
        disableDefaultEnvVars: true
      }
    }
  }
}

resource currencyserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'currencyservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/currencyservice/Dockerfile'
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
    codeReference: 'src/emailservice/Dockerfile'
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
    codeReference: 'src/frontend/Dockerfile'
    containers: {
      frontend: {
        image: frontendImage.properties.imageReference
        env: {
          AD_SERVICE_ADDR: {
            value: 'adservice-adservice:9555'
          }
          CART_SERVICE_ADDR: {
            value: 'cartservice-cartservice:7070'
          }
          CHECKOUT_SERVICE_ADDR: {
            value: 'checkoutservice-checkoutservice:5050'
          }
          CURRENCY_SERVICE_ADDR: {
            value: 'currencyservice-currencyservice:7000'
          }
          ENABLE_PROFILER: {
            value: '0'
          }
          PORT: {
            value: '8080'
          }
          PRODUCT_CATALOG_SERVICE_ADDR: {
            value: 'productcatalogservice-productcatalogservice:3550'
          }
          RECOMMENDATION_SERVICE_ADDR: {
            value: 'recommendationservice-recommendationservice:8080'
          }
          SHIPPING_SERVICE_ADDR: {
            value: 'shippingservice-shippingservice:50051'
          }
        }
        ports: {
          web: {
            containerPort: 8080
          }
        }
      }
    }
    connections: {
      adservice: {
        source: adserviceContainer.id
        disableDefaultEnvVars: true
      }
      cartservice: {
        source: cartserviceContainer.id
        disableDefaultEnvVars: true
      }
      checkoutservice: {
        source: checkoutserviceContainer.id
        disableDefaultEnvVars: true
      }
      currencyservice: {
        source: currencyserviceContainer.id
        disableDefaultEnvVars: true
      }
      productcatalogservice: {
        source: productcatalogserviceContainer.id
        disableDefaultEnvVars: true
      }
      recommendationservice: {
        source: recommendationserviceContainer.id
        disableDefaultEnvVars: true
      }
      shippingservice: {
        source: shippingserviceContainer.id
        disableDefaultEnvVars: true
      }
    }
  }
}

resource loadgeneratorContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'loadgenerator'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/loadgenerator/Dockerfile'
    containers: {
      loadgenerator: {
        image: loadgeneratorImage.properties.imageReference
        env: {
          FRONTEND_ADDR: {
            value: 'frontend-frontend:8080'
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
    connections: {
      frontend: {
        source: frontendContainer.id
        disableDefaultEnvVars: true
      }
    }
  }
}

resource paymentserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'paymentservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/paymentservice/Dockerfile'
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
    codeReference: 'src/productcatalogservice/Dockerfile'
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
    codeReference: 'src/recommendationservice/Dockerfile'
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
            value: 'productcatalogservice-productcatalogservice:3550'
          }
        }
        ports: {
          grpc: {
            containerPort: 8080
          }
        }
      }
    }
    connections: {
      productcatalogservice: {
        source: productcatalogserviceContainer.id
        disableDefaultEnvVars: true
      }
    }
  }
}

resource shippingserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'shippingservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/shippingservice/Dockerfile'
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

resource frontendRoute 'Radius.Compute/routes@2025-08-01-preview' = {
  name: 'frontend-route'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'kubernetes-manifests/frontend.yaml#L123'
    kind: 'HTTP'
    rules: [
      {
        matches: [
          {
            httpPath: '/'
          }
        ]
        destinationContainer: {
          resourceId: frontendContainer.id
          containerName: 'frontend'
          containerPort: 8080
        }
      }
    ]
  }
}
