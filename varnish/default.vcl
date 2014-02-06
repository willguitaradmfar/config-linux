# This is a basic VCL configuration file for varnish.  See the vcl(7)
# man page for details on VCL syntax and semantics.
# 
# Default backend definition.  Set this to point to your content
# server.
# 

backend local {
  .host = "127.0.0.1";
  .port = "3000";
}

acl purge {
	"localhost";
}

sub vcl_recv {
	set req.backend = local;

	if (req.http.Upgrade ~ "(?i)websocket") {
         return (pipe);
     }

	if (req.request == "PURGE") {
		if (!client.ip ~ purge) {
			error 405 "Not allowed.";
		}
		ban(req.url == req.url && req.http.host == req.http.host);
		error 200 "Purged.";
	}

	# Normalize Content-Encoding
	if (req.http.Accept-Encoding) {
		if (req.url ~ "\.(js|css|jpg|png|gif|gz|tgz|bz2|lzma|tbz|woff|less)(\?.*|)$") {
			remove req.http.Accept-Encoding;
		} elsif (req.http.Accept-Encoding ~ "gzip") {
			set req.http.Accept-Encoding = "gzip";
		} elsif (req.http.Accept-Encoding ~ "deflate") {
			set req.http.Accept-Encoding = "deflate";
		} else {
			remove req.http.Accept-Encoding;
		}
	}

	# Remove has_js and Google Analytics cookies.
	set req.http.Cookie = regsuball(req.http.Cookie, "(^|;\s*)(__[a-z]+|__utma_a2a|has_js)=[^;]*", "");

	# Remove cookies and query string for real static files
	if (req.url ~ "^/[^?]+\.(jpeg|jpg|png|gif|ico|js|css|sass|txt|gz|zip|lzma|bz2|tgz|tbz|woff|less)(\?.*|)$") {
		unset req.http.cookie;
		set req.url = regsub(req.url, "\?.*$", "");
	}
        if (req.url ~ "^/(evolution|accounts|tophashtags|topusers|gender).*$") {
                unset req.http.cookie;
        }

}

sub vcl_fetch {
	unset beresp.http.Set-Cookie;
	unset beresp.http.Cache-Control;
	unset beresp.http.expires;
	set beresp.do_gzip = true;

	if (req.url ~ "^/[^?]+\.(jpeg|jpg|png|gif|ico|js|css|sass|txt|gz|zip|lzma|bz2|tgz|tbz|woff|less)(\?.*|)$") {
		set beresp.http.Cache-Control = "max-age=31563000, s-maxage=31563000";
		set beresp.ttl = 365d;
	} else {
		set beresp.http.Cache-Control = "max-age=30, s-maxage=30";
		set beresp.ttl = 30s;
	}

	if (beresp.status == 301 || beresp.status == 302) { 
		return (hit_for_pass);
	}

	if (beresp.status == 500) { 
		return(restart);
	}

	set beresp.grace = 10m;
}

sub vcl_deliver {
    if (obj.hits > 0) {
        set resp.http.X-Cache = "HIT";
    } else {
        set resp.http.X-Cache = "MISS";
    }
}
