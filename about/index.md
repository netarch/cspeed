---
layout: page
title: The Internet at the Speed of Light
class: 'post'
navigation: True
current: about
full: True
---

{% include briefintro.html %}

### The Internet is too slow!

We fetched just the HTML for landing pages of _22,800_ popular Websites from 102_ PlanetLab nodes using [cURL](https://curl.haxx.se). For each connection, we geolocated the Web server using six commercial geolocation services, and (since we do not have any basis for deciding which service is better than another) used the location identified by their majority vote. We computed the time it would take for light to travel round-trip along the shortest path between the same end-points, i.e., the _c-latency_. We refer to the ratio of the fetch time to c-latency as the Internet’s latency _inflation_. The figure below shows the CDF of this inflation over _1.9 million_ connections. The time to finish HTML retrieval is, in the median, _36.5×_ the c-latency, while the 80<sup>th</sup> percentile exceeds _100×_. Thus, the Internet is typically more than an order of magnitude slower than the speed of light. Moreover, since PlanetLab nodes are generally well-connected, latency can be expected to be poorer from the Internet's _true edge_.

!["Fetch time of just the HTML of the landing pages of popular Websites in terms of inflation over the speed of light. In the median, fetch time is 36.5× slower."]({{ site.baseurl }}assets/plots/pam17-onlyTotal.png "Fetch time of just the HTML of the landing pages of popular Websites in terms of inflation over the speed of light. In the median, fetch time is 36.5× slower.")

### But why is the Internet so slow?

To identify the causes of Internet latency inflation, we break down the fetch time across layers, from inflation in the physical path followed by packets to the TCP transfer time.

!["Breakdown of latency inflation across various components of HTTP fetches of just the HTML of the landing pages of popular Web sites."]({{ site.baseurl }}assets/plots/pam17-pl-http-breakdown.png "Breakdown of latency inflation across various components of HTTP fetches of just the HTML of the landing pages of popular Web sites.")

DNS resolutions are shown to be faster than c-latency _14%_ of the time. This is an artifact of the baseline we use — in these cases, the Web server happens to be farther than the DNS resolver, and we always use the c-latency to the Web server as the baseline. (The DNS curve is clipped at the left to more clearly display the other results.) In the median, DNS resolutions are _6.6×_ inflated over c-latency.

The TCP transfer time shows significant inflation — _12.6×_ in the median. With most pages being at most tens of KB (median page size is _73 KB_), bandwidth is not the problem, but TCP’s slow start causes even small data transfers to require several RTTs. _6%_ of all pages have transfer times less than the c-latency — this is due to all the data being received in the first TCP window. The TCP handshake (counting only the _SYN_ and _SYN-ACK_) and the minimum ping time are _3.2×_ and _3.1×_ inflated in the median. The request-response time is _6.5×_ inflated in the median, i.e., roughly twice the median RTT. _24%_ of the connections, however, use less than _10 ms_ of server processing time (estimated by subtracting one RTT from the request-response time). The median c-latency, in comparison, is _47 ms_. The medians of inflation in DNS time, TCP handshake time, request-response time, and TCP transfer time add up to _28.8×_, lower than the measured median total time of _36.5×_, since the distributions are _heavy-tailed_.

### Infrastructural factor

In line with the community’s understanding, our measurements affirm that TCP transfer and DNS resolution are important factors causing latency inflation. Our measurements also reveal that, however, the Internet’s infrastructural inefficiencies are an equally, if not more important culprit.

Based on the above figure, DNS resolution (_6.6×_ inflated over c-latency), TCP handshake (_3.2×_), request-response time (_6.5×_), and TCP transfer (_12.6×_), all contribute to a total time inflation of _36.5×_. With these numbers, it may be tempting to dismiss the _3.1×_ inflation in the minimum ping time. But this would be incorrect because lower-layer inflation, embodied in RTT, has a multiplicative effect on each of DNS, TCP handshake, request-response, and TCP transfer time. The total time for a page fetch (without TLS) can be broken down roughly (ignoring minor factors like the client stack) as: _T<sub>total</sub> = T<sub>DNS</sub> + T<sub>handshake</sub> + T<sub>request</sub> + T<sub>serverproc</sub> + T<sub>response</sub> + T<sub>transfer</sub>_. If we changed the network’s RTTs as a whole by a factor of _x_, everything on the right-hand side except the server processing time (which can be made quite small in practice) changes by a factor of _x_ (to an approximation; TCP transfer time’s dependence on RTTs is a bit more complex), thus changing _T<sub>total</sub>_ by approximately a factor of _x_ as well.

### The Grand Challenge

There is a large body of work on reducing Internet latency. This work, however, has been limited in its scope, its scale, and most crucially, its ambition. The central question we have not seen answered, or even posed before, is _“Why are we so far from the speed of light?“_. Even the ramifications of a speed-of-light Internet have not been explored in any depth.

Speed-of-light Internet connectivity would be a technological leap with the potential for new applications, instant response, and radical changes in the interactions between people and computing. To shed light on what's keeping us from this vision, we quantified the latency gaps introduced by the Internet’s physical infrastructure and its network protocols. _Our analysis suggests that the networking community should, in addition to continuing efforts for protocol improvements, also explore methods of reducing latency at the lowest layers._


For more information on our analysis, data sets, and vision refer to our [publications]({{ site.baseurl }}publications).
