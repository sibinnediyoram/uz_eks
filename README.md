Task1:
 This part consists of the infrastructure deployment code and tools recommendation to make it as production grade.

Tools:
Cluster autoscaler: We can implement cluster autoscaler with threshold values such ad CPU utilization to trigger number of nodes in the cluster.

Jmeter: Performance Load testing and benchmark testing of the cluser . Once initial set of applications deployed into the EKS cluster we need to perform a benchmark test for the infra to figure out the weak points and then to improve it all.

Metrics: Cloudwatch to collect cluster events and logs.
         Instana/Newrelic - are APM tools and which will help us to collect difference metrics- Availability metrics, business metrics, app metrics, server metrics, events, observability, tracing, and alerting for the platform.

ELK stack: We need to collect all the logs from applications and cluster in a centralized way and ELK will help us to achieve it.

GitOps: GitOps approach will help us to make Git as the source of truth for entire platform and applications deployed. It will help us to be consistent even in a case of cluster loss.

ArgoCD: Argo is a GitOps tool, part of continuous delivery. Which will help us to implement the CD part in an automated way with a decent visualization.

Backup and Restore: For stateful components (databases). we need to ensure that timely backups are in place so that we will not loose data in case of any incident.

Monitoring tools:
Metrics server: It will collect metrices like CPU, Memory, IO etc.. We can implement horizontal pod autoscaler for applications pods based on the metrices 

Heapster: Heapster is a cluster-wide aggregator of monitoring and event data. It currently supports Kubernetes natively and works on all Kubernetes setups. Heapster runs as a pod in the cluster, similar to how any Kubernetes application would run. The Heapster pod discovers all nodes in the cluster and queries usage information from the nodes’ Kubelets, the on-machine Kubernetes agent. The Kubelet itself fetches the data from cAdvisor. We can save this metrics to any backend solutions like influxdb and can visualize the same for performance analysis using grafana.

Prometheus: Its time series database. We can use prometheus together with prometheus-nodexporter agents to collect all the metrices in terms of application pods, services, storage and many more and can use this for monitoring and alerting based on the thrshold values

Alert manager: Alertmanager is subtool of prometheus. Depends upon the metrics collected in prometheus, we can define alert rules and alert receivers which will help us to alert the engineers in case of any incidents and also we can use prometheus as a data source for Grafana to visualize the data.

Grafana: It is a visualization tool which will receive collected metrices from different monitoring tools like cloudwatch, prometheus, influxdb etc.. and we can use the same to visualize the collected data.

Thanos: Thanos is a persistent storage solution for prometheus since prometheus only used to save collected metrices for only one week. After that the data will get expire and it won't be feasible in case of a detailed analysis. So thanos will help us to collect and store the data from prometheus for a desired time frame and we decide expiration.

Opsgenie: Its an alerting tool which provided api to integrate with most kinds of the monitoring tools. Opsgenie will receive the alerts and will route it to configured mailids, phone numbers, messaging solutions like slack, msteams etc..

Cloudwatch: Since the cluster deployed to EKS, cloudwatch will be a great aws native tool to monitor the cluster and alert us in case of any threhold breakages.

Deployment approach:
We can go for canary deployments since it will help us to create separate set of pods of application and once it become healthy we can redirect a part of traffic to this new pods. Once the testing and verification completed we can scale the new application and can remove old one. 
We can use Argo, for deployments and kustomize and standalone k8s manifests to prepare the deployment.

Task2:
Jenkinspipeline file is updated in the repository and we can use the same to deploy the cluster. We can create cluster based tfvars file and can apply it with argument -var-file corresponding to respective cluster environments and configurations.

