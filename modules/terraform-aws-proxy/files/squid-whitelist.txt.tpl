# Cloudera CCMv2 for Persistent Control Plane connection
%{if cdp_region == "us-west-1" ~}
# ..US-based Control Plane
.v2.us-west-1.ccm.cdp.cloudera.com
%{ endif ~}

%{if cdp_region == "eu-1" ~}
# ..EU-based Control Plane
.v2.ccm.eu-1.cdp.cloudera.com
%{ endif ~}

%{if cdp_region == "ap-1" ~}
# ..AP-based Control Plane
.v2.ccm.ap-1.cdp.cloudera.com
%{ endif ~}

# Cloudera Databus for Telemetry, billing and metering data
%{if cdp_region == "us-west-1" ~}
# ..US-based Control Plane
dbusapi.us-west-1.sigma.altus.cloudera.com
cloudera-dbus-prod.s3.amazonaws.com
%{ endif ~}

%{if cdp_region == "eu-1" ~}
# ..EU-based Control Plane
api.eu-1.cdp.cloudera.com
# mow-prod-eu-central-1-sigmadbus-dbus.s3.eu-central-1.amazonaws.com # NOTE - this is a subdomain of the CDP AWS bucket with flow definitions for CDF below
mow-prod-eu-central-1-sigmadbus-dbus.s3.amazonaws.com
%{ endif ~}

%{if cdp_region == "ap-1" ~}
# ..AP-based Control Plane
api.ap-1.cdp.cloudera.com
mow-prod-ap-southeast-2-sigmadbus-dbus.s3.ap-southeast-2.amazonaws.com # NOTE - this is a subdomain of the CDP AWS bucket with flow definitions for CDF below
mow-prod-ap-southeast-2-sigmadbus-dbus.s3.amazonaws.com
%{ endif ~}

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

%{if cdp_region == "us-west-1" ~}
# ..US-based Control Plane
prod-us-west-2-starport-layer-bucket.s3.us-west-2.amazonaws.com
prod-us-west-2-starport-layer-bucket.s3.amazonaws.com
s3-r-w.us-west-2.amazonaws.com
.execute-api.us-west-2.amazonaws.com
%{ endif ~}

%{if cdp_region == "eu-1" ~}
# ..EU-based Control Plane
prod-eu-west-1-starport-layer-bucket.s3.eu-west-1.amazonaws.com
prod-eu-west-1-starport-layer-bucket.s3.amazonaws.com
s3-r-w.eu-west-1.amazonaws.com
.execute-api.eu-west-1.amazonaws.com
%{ endif ~}

%{if cdp_region == "ap-1" ~}
# ..AP-based Control Plane
prod-ap-southeast-1-starport-layer-bucket.s3.ap-southeast-1.amazonaws.com
prod-ap-southeast-1-starport-layer-bucket.s3.amazonaws.com
s3-r-w.ap-southeast-1.amazonaws.com
.execute-api.ap-southeast-1.amazonaws.com
%{ endif ~}

# CDP AWS bucket with flow definitions for CDF
%{if cdp_region == "us-west-1" ~}
# ..US-based Control Plane
.s3.us-west-1.amazonaws.com
%{ endif ~}

%{if cdp_region == "eu-1" ~}
# ..EU-based Control Plane
.s3.eu-central-1.amazonaws.com
%{ endif ~}

%{if cdp_region == "ap-1" ~}
# ..AP-based Control Plane
.s3.ap-southeast-2.amazonaws.com
%{ endif ~}

# Public Signing Key Retrieval for CDE and CDF
console.${cdp_region}.cdp.cloudera.com

%{if cdp_region == "us-west-1" ~}
# ..Additional for US-based Control Plane
consoleauth.altus.cloudera.com
%{ endif ~}

# SQL Stream Builder PostgreSQL driver install
pypi.org

# AMPs for CML incl Learning Hub
raw.githubusercontent.com
github.com

# AWS-specific endpoints
.eks.${aws_region}.amazonaws.com
.autoscaling.${aws_region}.amazonaws.com
.cloudformation.${aws_region}.amazonaws.com

# Additional endpoints for CDE deployment
cloudera.com
www.cloudera.com
truststore.pki.rds.amazonaws.com

# Additional endpoints for CDW deployment
amazonlinux-2-repos-${aws_region}.s3.dualstack.${aws_region}.amazonaws.com
iamapi.${cdp_region}.altus.cloudera.com
