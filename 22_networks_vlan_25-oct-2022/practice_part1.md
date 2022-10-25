## Practice --- How to set up VLANs

Prerequisites:
- Proxmox node with ~ 16 GiB RAM and ~ 90 GB local storage
- opnsense ISO
- proxmox ISO
- manjaro ISO

---------------------------------------------------------------------------
1. Create linux bridge vmbr1
* Proxmox UI: System > Network > [Create] > Linux bridge
    - Name
    - VLAN aware - checked
---------------------------------------------------------------------------
2. Create VM for opnsense (see <Lesson_16_Network_part-4-20221004>)
* set vmbr0 as WAN
* set vmbr1 as LAN
    - set up LAN (subnet mask)
* Firewall > Rules: close web to untagged VLAN (enable rule LAN to LAN only)
---------------------------------------------------------------------------
3. Create VM for manjaro > convert to template
* Create 1st linked clone from the manjaro template
    - Name: manjaro1
    - Network device: untagged VLAN (vmbr1)

* Check connectivity:
    - gateway
    - web

* Show logs:
    - Firewall > Live Log > filter by interface LAN
---------------------------------------------------------------------------
4. Create 2nd linked clone from the manjaro template
    - Name: manjaro2

* Go to opnsense to create VLAN 3:
    - Interfaces > Other Types > VLAN > [+]
    - Interfaces > Assignments > VLAN > [+]
    - In interfaces appeared new options, edit
        - enable
        - description
        - static ip
        - ipv4 - set address
    - Service > DHCPv4 *
    - Firewall > Aliases > RFC
    - Firewall > Rules > [+]
* Go back to manjaro:
    - Open Network Manager (nmtui)
        - edit a connection
        - wired connection to know parent edit
        - add a connection > vlan
            - device vlan03
            - parent ens 18
        - activate connection
        - deactivate wired connection
        - activate vlan 3 > Ok
    - Check ip address

* Check connectivity:
    - manjaro1 to manjaro2, gateway, web
    - manjaro2 to manjaro1, gateway, web
* Show logs:
    - Firewall > Live Log
---------------------------------------------------------------------------
5. Go to opnsense to create VLAN 20:
    - Interfaces > Other Types > VLAN > [+]
    - Interfaces > Assignments > VLAN > [+]
    - In interfaces appeared new options, edit
        - enable
        - description
        - static ip
        - ipv4 - set address
    - Service > DHCPv4 *
    - Firewall > Aliases > RFC
    - Firewall > Rules > [+]
* Create 3rd linked clone from the manjaro template
    - Name: manjaro3
    - set up VLAN 20 via Proxmox UI
* Check connectivity:
    - manjaro3 to manjaro2, manjaro1, gateway, web
    - manjaro1 to manjaro2, manjaro3
    - manjaro2 to manjaro3, manjaro1
---------------------------------------------------------------------------