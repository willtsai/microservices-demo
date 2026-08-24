extension radius

param environment string

@description('Username for the OCI registry the containerImages recipe pushes to.')
@secure()
param registryUsername string

@description('Password or token for the OCI registry the containerImages recipe pushes to.')
@secure()
param registryPassword string

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
    codeReference: 'src/cartservice/src/Startup.cs#L36'
    size: 'S'
  }
}

resource registryCreds 'Radius.Security/secrets@2025-08-01-preview' = {
  name: 'radius-ghcr-registry-creds'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: '.github/workflows/run-rad-commands-azure.yml#L219'
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

resource adServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'adservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/adservice/Dockerfile'
    tag: '3870470eaedc'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/adservice?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource cartServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'cartservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/cartservice/src/Dockerfile'
    tag: '3870470eaedc'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/cartservice/src?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource checkoutServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'checkoutservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/checkoutservice/Dockerfile'
    tag: '3870470eaedc'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/checkoutservice?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource currencyServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'currencyservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/currencyservice/Dockerfile'
    tag: '3870470eaedc'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/currencyservice?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource emailServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'emailservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/emailservice/Dockerfile'
    tag: '3870470eaedc'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/emailservice?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
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
    codeReference: 'src/frontend/Dockerfile'
    tag: '3870470eaedc'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/frontend?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource loadGeneratorImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'loadgenerator-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/loadgenerator/Dockerfile'
    tag: '3870470eaedc'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/loadgenerator?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource paymentServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'paymentservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/paymentservice/Dockerfile'
    tag: '3870470eaedc'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/paymentservice?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource productCatalogServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'productcatalogservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/productcatalogservice/Dockerfile'
    tag: '3870470eaedc'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/productcatalogservice?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource recommendationServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'recommendationservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/recommendationservice/Dockerfile'
    tag: '3870470eaedc'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/recommendationservice?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource shippingServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'shippingservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/shippingservice/Dockerfile'
    tag: '3870470eaedc'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/shippingservice?ref=3870470eaedc0ecc64224b4f127fe6f0dc9a1e22'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource adServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'adservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/adservice/Dockerfile'
    containers: {
      adService: {
        image: adServiceImage.properties.imageReference
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

resource cartServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'cartservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/cartservice/src/Dockerfile'
    containers: {
      cartService: {
        image: cartServiceImage.properties.imageReference
        env: {
          REDIS_ADDR: {
            valueFrom: {
              secretKeyRef: {
                secretName: redisCache.properties.secrets.name
                key: 'url'
              }
            }
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

resource checkoutServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'checkoutservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/checkoutservice/Dockerfile'
    containers: {
      checkoutService: {
        image: checkoutServiceImage.properties.imageReference
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
  }
  dependsOn: [
    cartServiceContainer
    currencyServiceContainer
    emailServiceContainer
    paymentServiceContainer
    productCatalogServiceContainer
    shippingServiceContainer
  ]
}

resource currencyServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'currencyservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/currencyservice/Dockerfile'
    containers: {
      currencyService: {
        image: currencyServiceImage.properties.imageReference
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

resource emailServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'emailservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/emailservice/Dockerfile'
    containers: {
      emailService: {
        image: emailServiceImage.properties.imageReference
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
  }
  dependsOn: [
    adServiceContainer
    cartServiceContainer
    checkoutServiceContainer
    currencyServiceContainer
    productCatalogServiceContainer
    recommendationServiceContainer
    shippingServiceContainer
  ]
}

resource loadGeneratorContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'loadgenerator'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/loadgenerator/Dockerfile'
    containers: {
      loadGenerator: {
        image: loadGeneratorImage.properties.imageReference
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
  }
  dependsOn: [
    frontendContainer
  ]
}

resource paymentServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'paymentservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/paymentservice/Dockerfile'
    containers: {
      paymentService: {
        image: paymentServiceImage.properties.imageReference
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

resource productCatalogServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'productcatalogservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/productcatalogservice/Dockerfile'
    containers: {
      productCatalogService: {
        image: productCatalogServiceImage.properties.imageReference
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

resource recommendationServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'recommendationservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/recommendationservice/Dockerfile'
    containers: {
      recommendationService: {
        image: recommendationServiceImage.properties.imageReference
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
  }
  dependsOn: [
    productCatalogServiceContainer
  ]
}

resource shippingServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'shippingservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/shippingservice/Dockerfile'
    containers: {
      shippingService: {
        image: shippingServiceImage.properties.imageReference
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
    codeReference: 'kustomize/base/frontend.yaml#L123'
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
