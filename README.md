# shoe-tube
Dockerized version of YouPHPTube

## Notes
* Creates a single docker container containing apache/php stack with both YouPHPTube & YouPHPTube-Encoder applications installed.  
* MySQL DB is external to this container


## ToDo
* Hardwire build file to specific version (remove apt-get update/upgrades) so build is repeatably immutable.
* Separate YouPHPTube & YouPHPTube-Encoder into separate containers for better and independent scalability.  
* Wire all containers together with docker compose(YouPHPTube, YouPHPTube-Encoder, MySQL, nginx)
