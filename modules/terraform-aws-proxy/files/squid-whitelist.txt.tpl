# Cloudera CCMv2 for Persistent Control Plane connection
# ..US-based Control Plane
%{if cdp_region == "us-west-1" }
.v2.us-west-1.ccm.cdp.cloudera.com
%{ endif }

# ..EU-based Control Plane
%{if cdp_region == "eu-1" }
.v2.ccm.eu-1.cdp.cloudera.com
%{ endif }

# ..AP-based Control Plane
%{if cdp_region == "ap-1" }
.v2.ccm.ap-1.cdp.cloudera.com
%{ endif }

# Cloudera Databus for Telemetry, billing and metering data
# ..US-based Control Plane
%{if cdp_region == "us-west-1" }
dbusapi.us-west-1.sigma.altus.cloudera.com
cloudera-dbus-prod.s3.amazonaws.com
%{ endif }

# ..EU-based Control Plane
%{if cdp_region == "eu-1" }
api.eu-1.cdp.cloudera.com
mow-prod-eu-central-1-sigmadbus-dbus.s3.eu-central-1.amazonaws.com
mow-prod-eu-central-1-sigmadbus-dbus.s3.amazonaws.com
%{ endif }

# ..AP-based Control Plane
%{if cdp_region == "ap-1" }
api.ap-1.cdp.cloudera.com
mow-prod-ap-southeast-2-sigmadbus-dbus.s3.ap-southeast-2.amazonaws.com
mow-prod-ap-southeast-2-sigmadbus-dbus.s3.amazonaws.com
%{ endif }

# Cloudera Manager parcels for Software distribution
archive.cloudera.com

# Control Plane API
api.${cdp_region}.cdp.cloudera.com

# Cloudera RPMs for workload agents
cloudera-service-delivery-cache.s3.amazonaws.com

# Docker Images for CDE, CDF, CML and CDW
container.repository.cloudera.com
docker.repository.cloudera.com

container.repo.cloudera.com

# ..US-based Control Plane
%{if cdp_region == "us-west-1" }
prod-us-west-2-starport-layer-bucket.s3.us-west-2.amazonaws.com
prod-us-west-2-starport-layer-bucket.s3.amazonaws.com
s3-r-w.us-west-2.amazonaws.com
.execute-api.us-west-2.amazonaws.com
%{ endif }

# ..EU-based Control Plane
%{if cdp_region == "eu-1" }
prod-eu-west-1-starport-layer-bucket.s3.eu-west-1.amazonaws.com
prod-eu-west-1-starport-layer-bucket.s3.amazonaws.com
s3-r-w.eu-west-1.amazonaws.com
.execute-api.eu-west-1.amazonaws.com
%{ endif }

# ..AP-based Control Plane
%{if cdp_region == "ap-1" }
prod-ap-southeast-1-starport-layer-bucket.s3.ap-southeast-1.amazonaws.com
prod-ap-southeast-1-starport-layer-bucket.s3.amazonaws.com
s3-r-w.ap-southeast-1.amazonaws.com
.execute-api.ap-southeast-1.amazonaws.com
%{ endif }

# CDP AWS bucket with flow definitions for CDF
# ..US-based Control Plane
%{if cdp_region == "us-west-1" }
.s3.us-west-1.amazonaws.com
%{ endif }

# ..EU-based Control Plane
%{if cdp_region == "eu-1" }
.s3.eu-central-1.amazonaws.com
%{ endif }

# ..AP-based Control Plane
%{if cdp_region == "ap-1" }
.s3.ap-southeast-2.amazonaws.com
%{ endif }

# Public Signing Key Retrieval for CDE and CDF
console.${cdp_region}.cdp.cloudera.com

# ..Additional for US-based Control Plane
%{if cdp_region == "us-west-1" }
consoleauth.altus.cloudera.com
%{ endif }

# SQL Stream Builder PostgreSQL driver install
pypi.org

# AMPs for CML incl Learning Hub
raw.githubusercontent.com
github.com

# AWS-specific endpoints
.eks.${aws_region}.amazonaws.com
.autoscaling.${aws_region}.amazonaws.com
.cloudformation.${aws_region}.amazonaws.com
# TODO: Any more needed here?

# TODO: Uncomment/update below if needed.

# CDE deployment
#cloudera.com
#www.cloudera.com
#truststore.pki.rds.amazonaws.com

# CDW deployment
#amazonlinux-2-repos-${aws_region}.s3.dualstack.${aws_region}.amazonaws.com

#iamapi.${cdp_region}.altus.cloudera.com


