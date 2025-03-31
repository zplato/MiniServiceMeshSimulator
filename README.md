# MiniServiceMeshSimulator

## Overview 
    Mini Service Mesh Simulator - Simulates multiple services, provides a central proxy/router to forward requests and adds timeouts, retries, circuit breaking etc. 
    Additionally, Simulate Network Faults and adds tracing/log correlation


## Goal
    Simulate multiple microservices communicating via a central router/proxy with:
    * Load balancing
    * Retries
    * Timeouts
    * Circuit breaking
    * Tracing / metrics

## Architecture
    Client --> ServiceMeshRouter --> Microservice A
                                     Microservice B
                                     Microservice C

Each microservice can respond, delay, or fail to simulate real-world scenarios.

## Directory Layout 
    MiniServiceMeshSimulator/
    ├── mesh_router.py         # Central request router
    ├── services/
    │   ├── service_a.py       # Flask app
    │   ├── service_b.py
    │   └── service_c.py
    ├── test/
    │   └── test_requests.py   # Load tests / validation
    ├── config/
    │   └── mesh_config.json   # Routing config, retry policy
    ├── utils/
    │   └── circuit_breaker.py # Circuit breaker logic
    ├── requirements.txt
    └── README.md
