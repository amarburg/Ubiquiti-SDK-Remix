.PHONY: ser2net set2net-clean ser2net-install

SER2NET_PKG=ser2net-2.7.tar.gz
SER2NET_URL=http://tenet.dl.sourceforge.net/project/ser2net/ser2net/2.7/$(SER2NET_PKG)
SER2NET_DIR=ser2net-2.7
SER2NET=ser2net


$(PACKAGEDIR)/$(SER2NET_PKG): $(PACKAGEDIR)
	curl -o $@ $(SER2NET_URL)

$(SER2NET_DIR): $(PACKAGEDIR)/$(SER2NET_PKG)
	tar -xzvf $^
     
$(SER2NET_DIR)/.configured: $(SER2NET_DIR)
	(cd $(SER2NET_DIR); \
		CC=${build_toolchain_prefix}gcc ./configure --host=mips-linux \
	)
	touch $(SER2NET_DIR)/.configured

ser2net: $(SER2NET_DIR)/.configured
	$(MAKE) -C ${SER2NET_DIR}

ser2net-clean:
	-test -f ${SER2NET_DIR}/Makefile && $(MAKE) -C ${SER2NET_DIR} clean
	rm -f ${SER2NET_DIR}/.configured ${SER2NET_DIR}/Makefile

ser2net-install: ser2net
	mkdir -p $(build_install_directory)/sbin
	cp -f ${SER2NET_DIR}/ser2net ${build_install_directory}/sbin
	$(STRIP) $(build_install_directory)/sbin/ser2net
	mkdir -p $(build_install_directory)/etc
