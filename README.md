# ACE* - Analytics of Covid Exposure Networks

The project explores possible applications of functional encryption (FE) on analyzing contact log data collected by [Corona-Warn-App](https://github.com/corona-warn-app) on mobile devices, based on [Exposure Notification protocol](https://blog.google/documents/Exposure_Notification_-Cryptography_Specification_v1.2.1.pdf). 

Exposure Notification protocol collects contact log data through registration of Bluetooth low energy transmissions in a highly privacy preserving manner, on user's mobile devices, that prevents reconstruction of contact/exposure network, including the information about the contacts and their (possible) contagion. 

The goal of [ACE* project](https://github.com/cryptohackathon/ace-net) is to demonstrate proof-of-concept modifications of the current version of the Corona-Warn-App's protocol, where mobile devices could transmit certain functionally encrypted data derived from its contact tracing logs to a central analytics server, which would enable calculation of certain contact network parameters related to social distancing, while still fully preserving privacy.

In this way, users and health authorities could benefit from insights from the field about social distancing and aggregated exposure risk.


## Objectives

The objective of this project is to get insights about the actual social distancing during Covid-19 epidemia, directly from the participants.

Our plan is to leverage the data of actual exposure networks, gathered by multiple Corona-Warn-App (CWA) apps, and their analysis, using [decentralized multi- client functional encryption for inner product ](https://eprint.iacr.org/2017/989.pdf) FE scheme, while at all steps respecting data privacy and safety, by processing a minimum of required personal data that is handled with maximum protection.

We have implemented proof-of-concept (PoC) implementation of the core infrastructure for trusted submitting, processing, and visualization of Covid-19 exposure networks, together with working simulation. 

Next step should be to bring this functionalities to the CWA app.


## Background

[Corona-Warn-App (CWA)](https://www.coronawarn.app) is an open source project (mobile app + servers) that helps trace infection chains of SARS-CoV-2. It is uses a decentralized approach, with focus on data privacy and safety, (Privacy-Preserving Contact Tracing specifications by [Apple](https://covid19.apple.com/contacttracing) & [Google](https://www.google.com/covid19/exposurenotifications)), and notifies users if they have been exposed. CWA is specifically designed to [ensure](https://blog.google/documents/Exposure_Notification_-Cryptography_Specification_v1.2.1.pdf) for each step that the app processes a minimum of required personal data that is handled with maximum protection - for the following 2 objectives:

- assess personal risk of infection, where the app
    - automatically collects nearby identifiers,
    - distributes list of keys of SARS-CoV-2 confirmed users,
    - checks for exposure to SARS-CoV-2 confirmed users,

- learn COVID-19 test results faster, where the app
    - enables communication (retrieve, inform) of user’s test result, after explicit consent from the user.   

In the context of exposure network analytics, where privacy of a user and his/her sensitive/health data (risk profile, encounters, data related to social distancing, etc.) is of utmost importance, decentralized functional encryption schemes can be used to securely calculate operations on the top of the encrypted data about the structure of exposure networks, comming from multiple users. For example, [GoFE](https://github.com/fentec-project/gofe) and [CiFEr](https://github.com/fentec-project/CiFEr) APIs provide cryptographic schemes for decentralization and functionalities up to quadratic functions. 

The communication between users's device eqipped with CWA and the server (CWA Infrastructure) is automated, mainly using pull mechanism, initiated from the user's device. The only exception is when users submits the positive test result for all user's encounters to be notified about possible infection. Mobile devices communicate only with servers and randomly submit requests, which are ignored by the servers, to prevent the attack from the malicious third party monitoring the traffic looking for communication patterns 

Hence, calculations and possible exposure checking always happen on the device; e.g. the device once per day pulls the data of all diagnosis keys (a.k.a temporary exposure keys of contagious people) and compares them with the encounter keys stored on the device from the given time interval. At these times, some interesting properties of the local encounter network are calculated and made available to the user, see e.g. [risk score calculation](https://www.r-bloggers.com/2020/09/risk-scoring-in-digital-contact-tracing-apps).

In the current version of the protocol, the data about the network and all encounters are stored in a secure storage on the device, see e.g. [here](https://covid19.apple.com/contacttracing). Due to privacy preservation, nobody (neither the app) has access to the network, including the local encounters. Hence, (without the protocol upgrade) we cannot reconstructure the parts of the network and can only use the data available on the application level, specifically:

- The number of days since the most recent exposure.
- For up to last 14 days:
    - The number of keys that matched for an exposure detection.
    - The highest, full-range risk score of all user’s exposures.
    - The highest risk score of all exposure incidents.
    - The sum of the full-range risk scores for all exposures for the user.

Actual information from the field, e.g. about social distancing (days since exposure), yesterday’s risk encounters (nr. of keys matched), and yesterday’s risk received (max, sum), can help in better management of the health crysis with less coercive measures. These data can be processed for a region, when region label is provided by the user or for the whole country. 

We can use functional encryption to process the data from multiple CWA apps on the analytics server, to get meaningful insights about exposure networks.
Health authorities now have a tool to specify the configuration settings that are used in risk score calculations and notification thresholds. 
Additionally, by lowering risky encounters (e.g. through efficient policies), the spread of the disease can be lowered, too.



## Topics for future work

- Bring the results of this project to Corona-Warn-App
- “Those who count the votes decide everything” - Voting systems (giving N votes between M >= N options)
- Randomising communication patterns, by involving a part (half?) of the requests to be ignored or by submitting data using secret sharing schemes (e.g. partial data, multiple times)


## Interesting references

- [Exposure Notification cryptography specification](https://blog.google/documents/Exposure_Notification_-Cryptography_Specification_v1.2.1.pdf)
- [Corona-Warn-App documentation](https://github.com/corona-warn-app/cwa-documentation)
- [Corona-Warn-App Solution Architecture](https://github.com/corona-warn-app/cwa-documentation/blob/master/solution_architecture.md)
- Kukkala VB, Saini JS, Iyengar SRS, [Privacy preserving network analysis of distributed social networks](https://eprint.iacr.org/2016/427.pdf), International Conference on Information Systems Security, 336-355, 2016
- VB Kukkala, SRS Iyengar, [Computing Betweenness Centrality: An Efficient Privacy-Preserving Approach](https://link.springer.com/chapter/10.1007/978-3-030-00434-7_2), International Conference on Cryptology and Network Security, 23-42
- VB Kukkala, SRS Iyengar, [Identifying Influential Spreaders in a Social Network (While Preserving Privacy)](https://content.sciendo.com/downloadpdf/journals/popets/2020/2/article-p537.pdf), Proceedings on Privacy Enhancing Technologies 2020 (2), 537-557




------------------------------------

## Selected challenge = Apply

Demonstrate a viable application of FE, for example, in the use case of access control or privacy-preserving AI, see [challenges](https://cryptohackathon.eu/#challenges) and [tutorial](https://us02web.zoom.us/rec/share/PeSRUAaUYbDBiN6AaQeszotTeALfuDyMyZxX5TbnfQxaGUGl4H_DGOCMeUmEToMD.0x18XGtN1pHHKGb1) (password: W$&k7Gwg).

Show the practicability and versatility of FE and reduce the entry barrier for researchers, engineers, product owners, architects to deploy FE in their solutions, ranging from prototypes to enterprise-ready products.

- Technical Execution (40 %)
    - How has the team effectively utilized the FE technologies?
    - How easy is the application to use?
    - How advanced is the prototype presented?
    - Is there a working demo?
    - Is the project well documented (readme, wiki), such that follow-up work is possible.
- Challenge Fit (20 %)
    - How relevant is the project to the stated challenge?
- Impact (40 %)
    - Will this solution have a far reach and market potential?



