extension radius

param environment string

@description('Username for the OCI registry the containerImages recipe pushes to.')
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

resource registryCreds 'Radius.Security/secrets@2025-08-01-preview' = {
  name: 'radius-ghcr-registry-creds'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/.github/workflows/run-rad-commands-azure.yml#L220'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/adservice/Dockerfile#L1'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/adservice?ref=42b2fc244aa7d5b6c82df058bed580845d2562f3'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/cartservice/src/Dockerfile#L1'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/cartservice/src?ref=42b2fc244aa7d5b6c82df058bed580845d2562f3'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/checkoutservice/Dockerfile#L1'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/checkoutservice?ref=42b2fc244aa7d5b6c82df058bed580845d2562f3'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/currencyservice/Dockerfile#L1'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/currencyservice?ref=42b2fc244aa7d5b6c82df058bed580845d2562f3'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/emailservice/Dockerfile#L1'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/emailservice?ref=42b2fc244aa7d5b6c82df058bed580845d2562f3'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/frontend/Dockerfile#L1'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/frontend?ref=42b2fc244aa7d5b6c82df058bed580845d2562f3'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/loadgenerator/Dockerfile#L1'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/loadgenerator?ref=42b2fc244aa7d5b6c82df058bed580845d2562f3'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/paymentservice/Dockerfile#L1'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/paymentservice?ref=42b2fc244aa7d5b6c82df058bed580845d2562f3'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/productcatalogservice/Dockerfile#L1'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/productcatalogservice?ref=42b2fc244aa7d5b6c82df058bed580845d2562f3'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/recommendationservice/Dockerfile#L1'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/recommendationservice?ref=42b2fc244aa7d5b6c82df058bed580845d2562f3'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/shippingservice/Dockerfile#L1'
    build: {
      source: 'git::https://github.com/willtsai/microservices-demo.git//src/shippingservice?ref=42b2fc244aa7d5b6c82df058bed580845d2562f3'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/adservice/src/main/java/hipstershop/AdService.java#L223'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/cartservice/src/Program.cs#L19'
    containers: {
      cartservice: {
        image: cartserviceImage.properties.imageReference
        env: {
          REDIS_ADDR: {
            value: '${redisCartContainer.properties.hosts['redis']}:6379'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/checkoutservice/main.go#L88'
    containers: {
      checkoutservice: {
        image: checkoutserviceImage.properties.imageReference
        env: {
          CART_SERVICE_ADDR: {
            value: '${cartserviceContainer.properties.hosts['cartservice']}:7070'
          }
          CURRENCY_SERVICE_ADDR: {
            value: '${currencyserviceContainer.properties.hosts['currencyservice']}:7000'
          }
          EMAIL_SERVICE_ADDR: {
            value: '${emailserviceContainer.properties.hosts['emailservice']}:8080'
          }
          PAYMENT_SERVICE_ADDR: {
            value: '${paymentserviceContainer.properties.hosts['paymentservice']}:50051'
          }
          PORT: {
            value: '5050'
          }
          PRODUCT_CATALOG_SERVICE_ADDR: {
            value: '${productcatalogserviceContainer.properties.hosts['productcatalogservice']}:3550'
          }
          SHIPPING_SERVICE_ADDR: {
            value: '${shippingserviceContainer.properties.hosts['shippingservice']}:50051'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/currencyservice/server.js#L182'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/emailservice/email_server.py#L118'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/frontend/main.go#L91'
    containers: {
      frontend: {
        image: frontendImage.properties.imageReference
        env: {
          AD_SERVICE_ADDR: {
            value: '${adserviceContainer.properties.hosts['adservice']}:9555'
          }
          CART_SERVICE_ADDR: {
            value: '${cartserviceContainer.properties.hosts['cartservice']}:7070'
          }
          CHECKOUT_SERVICE_ADDR: {
            value: '${checkoutserviceContainer.properties.hosts['checkoutservice']}:5050'
          }
          CURRENCY_SERVICE_ADDR: {
            value: '${currencyserviceContainer.properties.hosts['currencyservice']}:7000'
          }
          ENABLE_PROFILER: {
            value: '0'
          }
          PORT: {
            value: '8080'
          }
          PRODUCT_CATALOG_SERVICE_ADDR: {
            value: '${productcatalogserviceContainer.properties.hosts['productcatalogservice']}:3550'
          }
          RECOMMENDATION_SERVICE_ADDR: {
            value: '${recommendationserviceContainer.properties.hosts['recommendationservice']}:8080'
          }
          SHIPPING_SERVICE_ADDR: {
            value: '${shippingserviceContainer.properties.hosts['shippingservice']}:50051'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/loadgenerator/locustfile.py#L90'
    containers: {
      frontendCheck: {
        image: 'busybox:1.38.0@sha256:fd8d9aa63ba2f0982b5304e1ee8d3b90a210bc1ffb5314d980eb6962f1a9715d'
        command: [
          '/bin/sh'
          '-exc'
        ]
        args: [
          '''
MAX_RETRIES=12
RETRY_INTERVAL=10
for i in $(seq 1 $MAX_RETRIES); do
  STATUSCODE=$(wget --server-response http://${FRONTEND_ADDR} 2>&1 | awk '/^  HTTP/{print $2}')
  if [ $STATUSCODE -eq 200 ]; then
    exit 0
  fi
  sleep $RETRY_INTERVAL
done
exit 1
'''
        ]
        env: {
          FRONTEND_ADDR: {
            value: '${frontendContainer.properties.hosts['frontend']}:8080'
          }
        }
        initContainer: true
      }
      loadgenerator: {
        image: loadgeneratorImage.properties.imageReference
        env: {
          FRONTEND_ADDR: {
            value: '${frontendContainer.properties.hosts['frontend']}:8080'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/paymentservice/index.js#L73'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/productcatalogservice/server.go#L68'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/recommendationservice/recommendation_server.py#L130'
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
            value: '${productcatalogserviceContainer.properties.hosts['productcatalogservice']}:3550'
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

resource redisCartContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'redis-cart'
  properties: {
    environment: environment
    application: microservicesDemoApp.id
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/kubernetes-manifests/cartservice.yaml#L89'
    containers: {
      redis: {
        image: 'redis:alpine@sha256:8096655e437712b07503796fb64d81359256cfcff0ab29d95a7da72863786efb'
        ports: {
          redis: {
            containerPort: 6379
          }
        }
        volumeMounts: [
          {
            volumeName: 'redisData'
            mountPath: '/data'
          }
        ]
      }
    }
    volumes: {
      redisData: {
        emptyDir: {
          medium: 'disk'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/src/shippingservice/main.go#L56'
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
    codeReference: 'https://github.com/willtsai/microservices-demo/blob/willtsai-ubiquitous-parakeet/kubernetes-manifests/frontend.yaml#L123'
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
