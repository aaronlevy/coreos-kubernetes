# Kubelet Wrapper Script

The kubelet has some unique requirements, so we need to be able to run the kubelet in an unconstrained environment. However, we also want to ship the kubelet as a container image to take advantage of all that has to offer (image discovery, signing/verification, management).

The kubelet-wrapper is a helper-script shipped with CoreOS versions 960.0.0+. The script allows a deployer to easily run the kubelet as a container on the host system.

## Using the kubelet-wrapper

An example systemd kubelet.service file which takes advantage of the kubelet-wrapper script:

**/etc/systemd/system/kubelet.service**

```yaml
[Service]
Environment=KUBELET_VERSION=v1.1.7+coreos.1
ExecStart=/usr/lib/coreos/kubelet-wrapper \
  --api_servers=http://127.0.0.1:8080 \
  --config=/etc/kubernetes/manifests
```

In the example above we set the `KUBELET_VERSION` and the kubelet-wrapper script takes care of running the correct container image with all of the required options.

## Manual deployment

If you wish to use the kubelet-wrapper on a CoreOS version prior to 960.0.0, you can manually place the script on the host.

For example:

- Retrieve a copy of the [kubelet-wrapper script](https://github.com/coreos/coreos-overlay/blob/master/app-admin/kubelet-wrapper/files/kubelet-wrapper)
- Place on the host: `/etc/coreos/kubelet-wrapper`
- Reference from your kubelet service file:

    ```yaml
    [Service]
    Environment=KUBELET_VERSION=v1.1.7+coreos.1
    ExecStart=/etc/coreos/kubelet-wrapper \
      --api_servers=http://127.0.0.1:8080 \
      --config=/etc/kubernetes/manifests
    ```
