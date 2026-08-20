import QtQuick 2.15
import QtQuick.Window 2.15

/* openos-oak — OAK 安全中心 (独立 App)
 * 显示 OPENOS Security 状态: 子安全主体 / 白名单 / 握手 / 启动校验
 * 生产: 经 /proc/oak/* 实时读取
 */
Window {
    id: oakApp
    width: 560; height: 460
    flags: Qt.FramelessWindowHint
    title: "OPENOS Security"
    color: OpenUI.background

    Column {
        anchors.fill: parent; anchors.margins: OpenUI.sp5; spacing: OpenUI.sp4

        Row { width: parent.width
            Column { width: parent.width - 60
                Text { text: "OPENOS Security"; color: OpenUI.onSurface
                       font.pixelSize: OpenUI.typeHeadlineM; font.bold: true }
                Text { text: "OAK 加密体系 · 强制启用"; color: OpenUI.onSurfaceVariant
                       font.pixelSize: OpenUI.typeLabelL }
            }
            Rectangle { width: 32; height: 32; radius: OpenUI.shapeXs
                color: hover.hovered ? Qt.rgba(OpenUI.error.r, OpenUI.error.g,
                                               OpenUI.error.b, 0.3) : "transparent"
                ThemedIcon { anchors.centerIn: parent; name: "window-close"; ctx: "Actions"; size: 14; color: OpenUI.onSurface }
                MouseArea { id: hover; anchors.fill: parent; hoverEnabled: true
                    onClicked: oakApp.close() }
            }
        }

        // 状态总览
        Row { spacing: OpenUI.sp3; width: parent.width
            Rectangle { width: (parent.width - OpenUI.sp3)/2; height: 70; radius: OpenUI.shapeSm
                color: Qt.rgba(OpenUI.primary.r, OpenUI.primary.g, OpenUI.primary.b, 0.15)
                Column { anchors.centerIn: parent; spacing: 4
                    Text { text: "保护状态"; color: OpenUI.onSurfaceVariant; font.pixelSize: OpenUI.typeLabelM }
                    Row { spacing: OpenUI.sp1; anchors.horizontalCenter: parent.horizontalCenter
                        ThemedIcon { name: "checkmark"; ctx: "Actions"; size: 18; color: OpenUI.primary; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: "已启用"; color: OpenUI.primary; font.pixelSize: OpenUI.typeTitle; font.bold: true; verticalAlignment: Text.AlignVCenter }
                    }
                }
            }
            Rectangle { width: (parent.width - OpenUI.sp3)/2; height: 70; radius: OpenUI.shapeSm
                color: Qt.rgba(OpenUI.surfaceBright.r, OpenUI.surfaceBright.g,
                               OpenUI.surfaceBright.b, 0.4)
                Column { anchors.centerIn: parent; spacing: 4
                    Text { text: "启动校验"; color: OpenUI.onSurfaceVariant; font.pixelSize: OpenUI.typeLabelM }
                    Text { text: "OAK-Seal 通过"; color: OpenUI.primary; font.pixelSize: OpenUI.typeTitle; font.bold: true }
                }
            }
        }

        // 子安全主体
        Text { text: "内置子安全主体"; color: OpenUI.onSurface; font.pixelSize: OpenUI.typeTitle; font.bold: true }
        Rectangle { width: parent.width; height: 110; radius: OpenUI.shapeSm
            color: Qt.rgba(OpenUI.surfaceBright.r, OpenUI.surfaceBright.g,
                           OpenUI.surfaceBright.b, 0.4)
            Column { anchors.fill: parent; anchors.margins: OpenUI.sp4; spacing: 6
                Repeater { model: ListModel {
                    ListElement { name: "System";      desc: "内核看门狗" }
                    ListElement { name: "OPT";         desc: "包管理事务" }
                    ListElement { name: "Application"; desc: "应用生命周期" }
                }
                Row { width: parent.width; spacing: OpenUI.sp3
                    Text { width: 100; text: model.name; color: OpenUI.onSurface; font.pixelSize: OpenUI.typeBodyM; font.bold: true }
                    Text { width: 120; text: model.desc; color: OpenUI.onSurfaceVariant; font.pixelSize: OpenUI.typeLabelM }
                    Text { text: "已保护"; color: OpenUI.primary; font.pixelSize: OpenUI.typeLabelM }
                } }
            }
        }

        // 白名单 + 握手
        Row { spacing: OpenUI.sp3; width: parent.width
            Rectangle { width: (parent.width - OpenUI.sp3)/2; height: 90; radius: OpenUI.shapeSm
                color: Qt.rgba(OpenUI.surfaceBright.r, OpenUI.surfaceBright.g,
                               OpenUI.surfaceBright.b, 0.4)
                Column { anchors.fill: parent; anchors.margins: OpenUI.sp4; spacing: 4
                    Text { text: "认证白名单"; color: OpenUI.onSurface; font.pixelSize: OpenUI.typeLabelL; font.bold: true }
                    Text { text: "0 个第三方进程"; color: OpenUI.onSurfaceVariant; font.pixelSize: OpenUI.typeLabelM }
                }
            }
            Rectangle { width: (parent.width - OpenUI.sp3)/2; height: 90; radius: OpenUI.shapeSm
                color: Qt.rgba(OpenUI.surfaceBright.r, OpenUI.surfaceBright.g,
                               OpenUI.surfaceBright.b, 0.4)
                Column { anchors.fill: parent; anchors.margins: OpenUI.sp4; spacing: 4
                    Text { text: "安全连接"; color: OpenUI.onSurface; font.pixelSize: OpenUI.typeLabelL; font.bold: true }
                    Text { text: "OPEN RSA 握手可用"; color: OpenUI.onSurfaceVariant; font.pixelSize: OpenUI.typeLabelM }
                }
            }
        }
    }
}
