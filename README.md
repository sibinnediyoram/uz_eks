**Task1**:
 This part consists of the infrastructure deployment code and tools recommendation to make it as production grade.

Tools:
**Cluster autoscaler**: We can implement cluster autoscaler with threshold values such ad CPU utilization to trigger number of nodes in the cluster.

**Metrics**: Cloudwatch to collect cluster events and logs.
         Instana/Newrelic - are APM tools and which will help us to collect different metrices like Availability metrics, business metrics, app metrics, server metrics, events, observability, tracing, and alerting for the platform.

**ELK stack**: We need to collect all the logs from applications and cluster in a centralized way and ELK will help us to achieve it. We use fluentd as side car container with applications to pull the logs and then send to logstash using any message queuing system like cloudamqp, we cal also use logstash agent containers to collect logs from application pods. To avoid hectic management of self managed ELK stack we can go for Saas providers like Elastico.

**GitOps**: GitOps approach will help us to make Git as the single source of code for entire platform and applications deployed. It will help us to be consistent in terms of versioning and application deployments. 

**ArgoCD**: Argo is a GitOps tool, using for continuous delivery. Which will help us to implement the CD process and also provided a GUI. The UI is helpful to get the app version deployed and also we can apply manual triggers if needed.

**Backup and Restore**: For stateful components (databases). we need to ensure that timely backups are in place so that we will not loose data in case of any incident.

**Monitoring tools**:
**Zabbix**: We can use cloudwatch and zabbix integration to monitor the aws infra and also can use containerized zabbix agents deployed into the EKS cluster to monitor the nodes also.

**Metrics server**: It will collect metrices like CPU, Memory, IO etc.. We can implement horizontal pod autoscaler for application pods based on the metrices from metrics server. 

**Heapster**: Heapster is a cluster-wide aggregator of monitoring and event data. It currently supports Kubernetes natively and works on all Kubernetes setups. Heapster runs as a pod in the cluster, similar to how any Kubernetes application would run. The Heapster pod discovers all nodes in the cluster and queries usage information from the nodes’ Kubelets, the on-machine Kubernetes agent. The Kubelet itself fetches the data from cAdvisor. We can save this metrics to any backend solutions like influxdb and can visualize the same for performance analysis using grafana.

**Prometheus**: Its time series database. We can use prometheus together with prometheus-nodexporter agents to collect all the metrices in terms of application pods, services, storage and many more and can use this for monitoring and alerting based on the thrshold values. Prometheus is the leading open source monitoring and metrics collecting tool for containerized applications in the market.

**Alert manager**: Alertmanager is a subtool of prometheus. Depends upon the metrics collected in prometheus, we can define alert rules and alert receivers which will help us to alert the engineers in case of any incidents and also we can use prometheus as a data source for Grafana to visualize the data.

**Grafana**: It is a visualization tool which will receive collected metrices from different monitoring tools like cloudwatch, prometheus, influxdb etc.. and we can use the same to visualize the collected data.

**Thanos**: Thanos is a persistent storage solution for prometheus since prometheus only used to save collected metrices for 15 days by default. Eventhough we can extend the storage, it will cost additional disk space. So thanos will help us to collect and store the data from prometheus as a backend solution if we need to store the metrices for a longer time.

**Opsgenie**: Its an alerting tool which provided api to integrate with most kinds of the monitoring tools. Opsgenie will receive the alerts and will route it to configured mailids, phone numbers, messaging solutions like slack, msteams etc.. Opsgenie is one of the best and reliable tools for alerting purposes.

**Cloudwatch**: Since the cluster deployed to Amazon EKS, cloudwatch is the aws native tool to monitor the cluster and to manage alerts and thresholds.

**Deployment approach**:
We can go for canary deployments since it will help us to create separate set of pods of application and once it become healthy we can redirect a part of traffic to this new pods. Once the testing and verification completed we can scale the new application and can remove old one. 
We can use Argo, for deployments and kustomize or helm and standalone k8s manifests to prepare the deployment.

**Task2**:
Jenkinspipeline file is updated in the repository and we can use the same to deploy the cluster. We can create multiple tfvars files for each environment where we need to create the eks cluster and can apply it with argument -var-file corresponding to respective cluster environments and configurations. Also we can isolate the statefiles using workspace switching.

