extension radius

param environment string

@description('Username for the OCI registry the containerImages recipe pushes to (the GitHub actor for ghcr.io).')
@secure()
param registryUsername string

@description('Password/token for the OCI registry the containerImages recipe pushes to (a GitHub token with write:packages for ghcr.io).')
@secure()
param registryPassword string

resource microservicesDemoApp 'Radius.Core/applications@2025-08-01-preview' = {
  name: 'microservices-demo'
  properties: {
    environment: environment
  }
}

resource registryCreds 'Radius.Security/secrets@2025-08-01-preview' = {
  name: 'radius-ghcr-registry-creds'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: '.github/workflows/run-rad-commands-azure.yml#L232'
    data: {
      username: {
        value: registryUsername
      }
      password: {
        value: registryPassword
      }
    }
  }
}

resource adserviceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'adservice-image'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/adservice/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/adservice?ref=2caeaa3224f6df9379ee88152aa2cbc54f82853d'
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
    codeReference: 'src/cartservice/src/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/cartservice/src?ref=2caeaa3224f6df9379ee88152aa2cbc54f82853d'
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
    codeReference: 'src/checkoutservice/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/checkoutservice?ref=2caeaa3224f6df9379ee88152aa2cbc54f82853d'
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
    codeReference: 'src/currencyservice/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/currencyservice?ref=2caeaa3224f6df9379ee88152aa2cbc54f82853d'
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
    codeReference: 'src/emailservice/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/emailservice?ref=2caeaa3224f6df9379ee88152aa2cbc54f82853d'
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
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/frontend?ref=2caeaa3224f6df9379ee88152aa2cbc54f82853d'
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
    codeReference: 'src/loadgenerator/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/loadgenerator?ref=2caeaa3224f6df9379ee88152aa2cbc54f82853d'
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
    codeReference: 'src/paymentservice/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/paymentservice?ref=2caeaa3224f6df9379ee88152aa2cbc54f82853d'
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
    codeReference: 'src/productcatalogservice/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/productcatalogservice?ref=2caeaa3224f6df9379ee88152aa2cbc54f82853d'
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
    codeReference: 'src/recommendationservice/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/recommendationservice?ref=2caeaa3224f6df9379ee88152aa2cbc54f82853d'
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
    codeReference: 'src/shippingservice/Dockerfile'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/shippingservice?ref=2caeaa3224f6df9379ee88152aa2cbc54f82853d'
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
    codeReference: 'src/adservice/src/main/java/hipstershop/AdService.java#L223'
    containers: {
      adservice: {
        image: adserviceImage.properties.imageReference
        ports: {
          grpc: {
            containerPort: 9555
          }
        }
        env: {
          PORT: {
            value: '9555'
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
    codeReference: 'src/cartservice/src/Program.cs#L19'
    containers: {
      cartservice: {
        image: cartserviceImage.properties.imageReference
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
    codeReference: 'src/checkoutservice/main.go#L127'
    containers: {
      checkoutservice: {
        image: checkoutserviceImage.properties.imageReference
        ports: {
          grpc: {
            containerPort: 5050
          }
        }
        env: {
          PORT: {
            value: '5050'
          }
          PRODUCT_CATALOG_SERVICE_ADDR: {
            value: '${productcatalogserviceContainer.properties.hosts.productcatalogservice}:3550'
          }
          SHIPPING_SERVICE_ADDR: {
            value: '${shippingserviceContainer.properties.hosts.shippingservice}:50051'
          }
          PAYMENT_SERVICE_ADDR: {
            value: '${paymentserviceContainer.properties.hosts.paymentservice}:50051'
          }
          EMAIL_SERVICE_ADDR: {
            value: '${emailserviceContainer.properties.hosts.emailservice}:8080'
          }
          CURRENCY_SERVICE_ADDR: {
            value: '${currencyserviceContainer.properties.hosts.currencyservice}:7000'
          }
          CART_SERVICE_ADDR: {
            value: '${cartserviceContainer.properties.hosts.cartservice}:7070'
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
    codeReference: 'src/currencyservice/server.js#L188'
    containers: {
      currencyservice: {
        image: currencyserviceImage.properties.imageReference
        ports: {
          grpc: {
            containerPort: 7000
          }
        }
        env: {
          PORT: {
            value: '7000'
          }
          DISABLE_PROFILER: {
            value: '1'
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
    codeReference: 'src/emailservice/email_server.py#L131'
    containers: {
      emailservice: {
        image: emailserviceImage.properties.imageReference
        ports: {
          grpc: {
            containerPort: 8080
          }
        }
        env: {
          PORT: {
            value: '8080'
          }
          DISABLE_PROFILER: {
            value: '1'
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
    codeReference: 'src/frontend/main.go#L171'
    containers: {
      frontend: {
        image: frontendImage.properties.imageReference
        ports: {
          web: {
            containerPort: 8080
          }
        }
        env: {
          PORT: {
            value: '8080'
          }
          PRODUCT_CATALOG_SERVICE_ADDR: {
            value: '${productcatalogserviceContainer.properties.hosts.productcatalogservice}:3550'
          }
          CURRENCY_SERVICE_ADDR: {
            value: '${currencyserviceContainer.properties.hosts.currencyservice}:7000'
          }
          CART_SERVICE_ADDR: {
            value: '${cartserviceContainer.properties.hosts.cartservice}:7070'
          }
          RECOMMENDATION_SERVICE_ADDR: {
            value: '${recommendationserviceContainer.properties.hosts.recommendationservice}:8080'
          }
          SHIPPING_SERVICE_ADDR: {
            value: '${shippingserviceContainer.properties.hosts.shippingservice}:50051'
          }
          CHECKOUT_SERVICE_ADDR: {
            value: '${checkoutserviceContainer.properties.hosts.checkoutservice}:5050'
          }
          AD_SERVICE_ADDR: {
            value: '${adserviceContainer.properties.hosts.adservice}:9555'
          }
          SHOPPING_ASSISTANT_SERVICE_ADDR: {
            value: 'shoppingassistantservice:80'
          }
          ENABLE_PROFILER: {
            value: '0'
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
    codeReference: '.radius/app.bicep#L407'
    containers: {
      loadgenerator: {
        image: loadgeneratorImage.properties.imageReference
        env: {
          FRONTEND_ADDR: {
            value: '${frontendContainer.properties.hosts.frontend}:8080'
          }
          USERS: {
            value: '10'
          }
          RATE: {
            value: '1'
          }
        }
      }
    }
  }
}

resource paymentserviceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'paymentservice'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'src/paymentservice/index.js#L75'
    containers: {
      paymentservice: {
        image: paymentserviceImage.properties.imageReference
        ports: {
          grpc: {
            containerPort: 50051
          }
        }
        env: {
          PORT: {
            value: '50051'
          }
          DISABLE_PROFILER: {
            value: '1'
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
    codeReference: 'src/productcatalogservice/server.go#L124'
    containers: {
      productcatalogservice: {
        image: productcatalogserviceImage.properties.imageReference
        ports: {
          grpc: {
            containerPort: 3550
          }
        }
        env: {
          PORT: {
            value: '3550'
          }
          DISABLE_PROFILER: {
            value: '1'
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
    codeReference: 'src/recommendationservice/recommendation_server.py#L148'
    containers: {
      recommendationservice: {
        image: recommendationserviceImage.properties.imageReference
        ports: {
          grpc: {
            containerPort: 8080
          }
        }
        env: {
          PORT: {
            value: '8080'
          }
          PRODUCT_CATALOG_SERVICE_ADDR: {
            value: '${productcatalogserviceContainer.properties.hosts.productcatalogservice}:3550'
          }
          DISABLE_PROFILER: {
            value: '1'
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
    codeReference: 'src/shippingservice/main.go#L78'
    containers: {
      shippingservice: {
        image: shippingserviceImage.properties.imageReference
        ports: {
          grpc: {
            containerPort: 50051
          }
        }
        env: {
          PORT: {
            value: '50051'
          }
          DISABLE_PROFILER: {
            value: '1'
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
    kind: 'HTTP'
    codeReference: 'kubernetes-manifests/frontend.yaml#L124'
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
