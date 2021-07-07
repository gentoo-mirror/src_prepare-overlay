# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#inherit go-module

EGO_SUM=(
	"github.com/AlecAivazis/survey v1.4.1"
	"github.com/Azure/go-ansiterm v0.0.0-20170929234023-d6e3b3328b78"
	"github.com/NYTimes/gziphandler v0.0.0-20180227021810-5032c8878b9d"
	"github.com/StackExchange/wmi v0.0.0-20180725035823-b12b22c5341f"
	"github.com/ash2k/stager v0.0.0-20170622123058-6e9c7b0eacd4"
	"github.com/atlassian/gostatsd v0.0.0-20180514010436-af796620006e"
	"github.com/coreos/bbolt v1.3.3"
	"github.com/coreos/etcd v3.3.17+incompatible"
	"github.com/coreos/go-semver v0.3.0"
	"github.com/coreos/go-systemd v0.0.0-20190719114852-fd7a80b32e1f"
	"github.com/coreos/pkg v0.0.0-20180928190104-399ea9e2e55f"
	"github.com/dave/jennifer v0.0.0-20171207062344-d8bdbdbee4e1"
	"github.com/dgrijalva/jwt-go v3.2.0+incompatible"
	"github.com/docker/docker v0.0.0-20180409082103-cbde00b44273"
	"github.com/echlebek/crock v1.0.1"
	"github.com/echlebek/timeproxy v1.0.0"
	"github.com/emicklei/proto v1.1.0"
	"github.com/frankban/quicktest v1.7.2"
	"github.com/ghodss/yaml v1.0.0"
	"github.com/go-ole/go-ole v0.0.0-20170209151332-de8695c8edbf"
	"github.com/go-resty/resty/v2 v2.1.0"
	"github.com/gogo/protobuf v1.3.1"
	"github.com/golang/groupcache v0.0.0-20191002201903-404acd9df4cc"
	"github.com/golang/protobuf v1.3.2"
	"github.com/google/uuid v1.1.1"
	"github.com/gorilla/context v0.0.0-20160226214623-1ea25387ff6f"
	"github.com/gorilla/mux v1.6.2"
	"github.com/gorilla/websocket v1.4.1"
	"github.com/gotestyourself/gotestyourself v2.2.0+incompatible"
	"github.com/graph-gophers/dataloader v0.0.0-20180104184831-78139374585c"
	"github.com/graphql-go/graphql v0.7.9-0.20191125031726-2e2b648ecbe4"
	"github.com/grpc-ecosystem/go-grpc-middleware v1.1.0"
	"github.com/grpc-ecosystem/grpc-gateway v1.11.3"
	"github.com/gxed/GoEndian v0.0.0-20160916112711-0f5c6873267e"
	"github.com/gxed/eventfd v0.0.0-20160916113412-80a92cca79a8"
	"github.com/hashicorp/go-version v1.2.0"
	"github.com/ipfs/go-log v0.0.0-20180416040000-7ecd3df29a4a"
	"github.com/jbenet/go-reuseport v0.0.0-20180416043609-15a1cd37f050"
	"github.com/json-iterator/go v1.1.7"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.2"
	"github.com/libp2p/go-reuseport v0.0.0-20180416043609-15a1cd37f050"
	"github.com/libp2p/go-sockaddr v0.0.0-20180329070516-f3e9f73a53d1"
	"github.com/mattn/go-colorable v0.0.9"
	"github.com/mattn/go-isatty v0.0.2"
	"github.com/mattn/go-runewidth v0.0.2"
	"github.com/mgutz/ansi v0.0.0-20170206155736-9520e82c474b"
	"github.com/mholt/archiver/v3 v3.3.1-0.20191129193105-44285f7ed244"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/mapstructure v1.1.2"
	"github.com/olekukonko/tablewriter v0.0.0-20180506121414-d4647c9c7a84"
	"github.com/prometheus/client_golang v1.2.0"
	"github.com/prometheus/client_model v0.0.0-20190812154241-14fe0d1b01d4"
	"github.com/robertkrimen/otto v0.0.0-20180617131154-15f95af6e78d"
	"github.com/robfig/cron/v3 v3.0.0"
	"github.com/sensu/lasr v1.2.1"
	"github.com/shirou/gopsutil v0.0.0-20180801053943-8048a2e9c577"
	"github.com/shirou/w32 v0.0.0-20160930032740-bb4de0191aa4"
	"github.com/sirupsen/logrus v1.4.2"
	"github.com/spf13/cobra v0.0.5"
	"github.com/spf13/pflag v1.0.5"
	"github.com/spf13/viper v1.4.0"
	"github.com/stretchr/testify v1.4.0"
	"github.com/whyrusleeping/go-logging v0.0.0-20170515211332-0457bb6b88fc"
	"github.com/willf/pad v0.0.0-20160331131008-b3d780601022"
	"go.etcd.io/bbolt v1.3.2"
	"go.uber.org/multierr v1.2.0"
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550"
	"golang.org/x/net v0.0.0-20191014212845-da9a3fd4c582"
	"golang.org/x/sys v0.0.0-20191113165036-4c7a9d0fe056"
	"golang.org/x/text v0.3.2"
	"golang.org/x/time v0.0.0-20190921001708-c4c64cad1fd0"
	"google.golang.org/genproto v0.0.0-20191009194640-548a555dbc03"
	"google.golang.org/grpc v1.24.0"
	"gopkg.in/AlecAivazis/survey.v1 v1.4.0"
	"gopkg.in/h2non/filetype.v1 v1.0.3"
	"gopkg.in/sourcemap.v1 v1.0.5"
	"gopkg.in/yaml.v2 v2.2.4"
	"gotest.tools v2.2.0+incompatible"
	"sigs.k8s.io/yaml v1.1.0"
)

#go-module_set_globals

DESCRIPTION="Simple. Scalable. Multi-cloud monitoring."
HOMEPAGE="https://sensu.io"
#SRC_URI="
#	https://github.com/${PN}/${PN}-go/archive/v${PV}.tar.gz -> ${P}.tar.gz
#	${EGO_SUM_SRC_URI}"

MAJOR_MINOR_VERSION="5.19"
SRC_URI="
	https://github.com/${PN}/${PN}-go/archive/v${PV}.tar.gz -> ${P}.tar.gz
	backend? ( https://docs.sensu.io/sensu-go/${MAJOR_MINOR_VERSION}/files/backend.yml -> ${PN}_${PV}_backend.yml )
	agent? ( https://docs.sensu.io/sensu-go/${MAJOR_MINOR_VERSION}/files/agent.yml -> ${PN}_${PV}_agent.yml )
"

PROPERTIES+=" live"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc64 ~x86"

IUSE="agent backend gcc systemd"

BDEPEND+="
	!gcc? ( dev-lang/go )
	gcc? ( sys-devel/gcc[go] )
	sys-apps/coreutils
	app-arch/tar
	app-arch/gzip
"

RDEPEND+="
	virtual/libc
	acct-group/sensu
	acct-user/sensu
"

#S="${S}/${PN}"
#S="${WORKDIR}/${PN}-go-${PV}"
S="${WORKDIR}"

src_unpack() {
	if [ -z ${I_KNOW_WHAT_IM_DOING} ]; then
		local I_KNOW_WHAT_IM_DOING=0
	fi
	if use gcc; then
		die "Compilation with GCC is not supported yet."
	fi
	if use systemd; then
		die "We don't have systemd unit files yet."
	fi
	if use backend && (use x86 || use arm) && [ ${I_KNOW_WHAT_IM_DOING} -eq 0 ]; then
		die "Backend does not work reliably on 32bit hosts. If you really want this, re-emerge with I_KNOW_WHAT_IM_DOING=1"
	fi
	tar -xf "${DISTDIR}"/sensu-${PV}.tar.gz
	cd ${PN}-go-${PV}
	local TODAY=$(date +%Y-%m-%d)
	local BUILD_SIGNATURE="-X github.com/sensu/sensu-go/version.Version=${PV} -X github.com/sensu/sensu-go/version.BuildDate=${TODAY}"
	if use agent; then
		go build -ldflags "${BUILD_SIGNATURE}" -o bin/sensu-agent ./cmd/sensu-agent >/dev/null
		cp "${DISTDIR}"/"${PN}"_"${PV}"_agent.yml "${S}"/agent.yml.example
	fi
	if use backend; then
		go build -ldflags "${BUILD_SIGNATURE}" -o bin/sensu-backend ./cmd/sensu-backend >/dev/null
		cp "${DISTDIR}"/"${PN}"_"${PV}"_backend.yml "${S}"/backend.yml.example
	fi
	go build -ldflags "${BUILD_SIGNATURE}" -o bin/sensuctl ./cmd/sensuctl >/dev/null
}

src_install() {
	if use agent; then
		doinitd "${FILESDIR}"/init.d/sensu-agent
		doconfd "${FILESDIR}"/conf.d/sensu-agent
		insinto /etc/sensu
		doins agent.yml.example
		dosbin "${PN}-go-${PV}"/bin/sensu-agent
	fi
	if use backend; then
		doexe "${FILESDIR}"/init.d/sensu-backend
		doins "${FILESDIR}"/conf.d/sensu-backend
		insinto /etc/sensu
		doins backend.yml.example
		dosbin "${PN}-go-${PV}"/bin/sensu-backend
	fi
	dosbin "${PN}-go-${PV}"/bin/sensuctl
}

pkg_postinst() {
	if use backend; then
		elog "If this is your first installation of sensu backend,"
		elog "you have to initialize your administrative credentials."
		elog "Simply run the following: (change admin_user and admin_password)"
		elog "su -s /bin/bash - sensu -c 'SENSU_BACKEND_CLUSTER_ADMIN_USERNAME=admin_user SENSU_BACKEND_CLUSTER_ADMIN_PASSWORD=admin_pass sensu-backend init'"
		elog "Remember that this command has to be run WHILE sensu-backend service is running."
	fi
}
