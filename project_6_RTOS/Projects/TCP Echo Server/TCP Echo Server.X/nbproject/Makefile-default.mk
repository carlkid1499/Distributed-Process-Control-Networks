#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/TCP_Echo_Server.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/TCP_Echo_Server.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS

else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=../../../FreeRTOS/Source/portable/MPLAB/PIC32MX/port.c ../../../FreeRTOS/Source/portable/MPLAB/PIC32MX/port_asm.S ../../../FreeRTOS/Source/event_groups.c ../../../FreeRTOS/Source/list.c ../../../FreeRTOS/Source/queue.c ../../../FreeRTOS/Source/tasks.c ../../../FreeRTOS/Source/portable/MemMang/heap_4.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement/BufferAllocation_2.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_ARP.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_DHCP.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_DNS.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_IP.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_Sockets.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_Stream_Buffer.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_TCP_IP.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_TCP_WIN.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_UDP_IP.c ../Ethernet_ISR.S ../NetworkInterface.c ../PHYGeneric.c ../PHY_isr.S ../ETHPIC32ExtPhy.c ../ETHPIC32ExtPhySMSC8720.c ../LAN8720A.c ../chipKIT_PRO_MX7.c ../main.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1599763551/port.o ${OBJECTDIR}/_ext/1599763551/port_asm.o ${OBJECTDIR}/_ext/190470153/event_groups.o ${OBJECTDIR}/_ext/190470153/list.o ${OBJECTDIR}/_ext/190470153/queue.o ${OBJECTDIR}/_ext/190470153/tasks.o ${OBJECTDIR}/_ext/636803636/heap_4.o ${OBJECTDIR}/_ext/1365677990/BufferAllocation_2.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_ARP.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_DHCP.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_DNS.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_IP.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_Sockets.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_Stream_Buffer.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_IP.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_WIN.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_UDP_IP.o ${OBJECTDIR}/_ext/1472/Ethernet_ISR.o ${OBJECTDIR}/_ext/1472/NetworkInterface.o ${OBJECTDIR}/_ext/1472/PHYGeneric.o ${OBJECTDIR}/_ext/1472/PHY_isr.o ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhy.o ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhySMSC8720.o ${OBJECTDIR}/_ext/1472/LAN8720A.o ${OBJECTDIR}/_ext/1472/chipKIT_PRO_MX7.o ${OBJECTDIR}/_ext/1472/main.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1599763551/port.o.d ${OBJECTDIR}/_ext/1599763551/port_asm.o.d ${OBJECTDIR}/_ext/190470153/event_groups.o.d ${OBJECTDIR}/_ext/190470153/list.o.d ${OBJECTDIR}/_ext/190470153/queue.o.d ${OBJECTDIR}/_ext/190470153/tasks.o.d ${OBJECTDIR}/_ext/636803636/heap_4.o.d ${OBJECTDIR}/_ext/1365677990/BufferAllocation_2.o.d ${OBJECTDIR}/_ext/801913726/FreeRTOS_ARP.o.d ${OBJECTDIR}/_ext/801913726/FreeRTOS_DHCP.o.d ${OBJECTDIR}/_ext/801913726/FreeRTOS_DNS.o.d ${OBJECTDIR}/_ext/801913726/FreeRTOS_IP.o.d ${OBJECTDIR}/_ext/801913726/FreeRTOS_Sockets.o.d ${OBJECTDIR}/_ext/801913726/FreeRTOS_Stream_Buffer.o.d ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_IP.o.d ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_WIN.o.d ${OBJECTDIR}/_ext/801913726/FreeRTOS_UDP_IP.o.d ${OBJECTDIR}/_ext/1472/Ethernet_ISR.o.d ${OBJECTDIR}/_ext/1472/NetworkInterface.o.d ${OBJECTDIR}/_ext/1472/PHYGeneric.o.d ${OBJECTDIR}/_ext/1472/PHY_isr.o.d ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhy.o.d ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhySMSC8720.o.d ${OBJECTDIR}/_ext/1472/LAN8720A.o.d ${OBJECTDIR}/_ext/1472/chipKIT_PRO_MX7.o.d ${OBJECTDIR}/_ext/1472/main.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1599763551/port.o ${OBJECTDIR}/_ext/1599763551/port_asm.o ${OBJECTDIR}/_ext/190470153/event_groups.o ${OBJECTDIR}/_ext/190470153/list.o ${OBJECTDIR}/_ext/190470153/queue.o ${OBJECTDIR}/_ext/190470153/tasks.o ${OBJECTDIR}/_ext/636803636/heap_4.o ${OBJECTDIR}/_ext/1365677990/BufferAllocation_2.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_ARP.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_DHCP.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_DNS.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_IP.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_Sockets.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_Stream_Buffer.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_IP.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_WIN.o ${OBJECTDIR}/_ext/801913726/FreeRTOS_UDP_IP.o ${OBJECTDIR}/_ext/1472/Ethernet_ISR.o ${OBJECTDIR}/_ext/1472/NetworkInterface.o ${OBJECTDIR}/_ext/1472/PHYGeneric.o ${OBJECTDIR}/_ext/1472/PHY_isr.o ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhy.o ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhySMSC8720.o ${OBJECTDIR}/_ext/1472/LAN8720A.o ${OBJECTDIR}/_ext/1472/chipKIT_PRO_MX7.o ${OBJECTDIR}/_ext/1472/main.o

# Source Files
SOURCEFILES=../../../FreeRTOS/Source/portable/MPLAB/PIC32MX/port.c ../../../FreeRTOS/Source/portable/MPLAB/PIC32MX/port_asm.S ../../../FreeRTOS/Source/event_groups.c ../../../FreeRTOS/Source/list.c ../../../FreeRTOS/Source/queue.c ../../../FreeRTOS/Source/tasks.c ../../../FreeRTOS/Source/portable/MemMang/heap_4.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement/BufferAllocation_2.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_ARP.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_DHCP.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_DNS.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_IP.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_Sockets.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_Stream_Buffer.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_TCP_IP.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_TCP_WIN.c ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_UDP_IP.c ../Ethernet_ISR.S ../NetworkInterface.c ../PHYGeneric.c ../PHY_isr.S ../ETHPIC32ExtPhy.c ../ETHPIC32ExtPhySMSC8720.c ../LAN8720A.c ../chipKIT_PRO_MX7.c ../main.c


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/TCP_Echo_Server.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=32MX795F512L
MP_LINKER_FILE_OPTION=
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1599763551/port_asm.o: ../../../FreeRTOS/Source/portable/MPLAB/PIC32MX/port_asm.S  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1599763551" 
	@${RM} ${OBJECTDIR}/_ext/1599763551/port_asm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1599763551/port_asm.o 
	@${RM} ${OBJECTDIR}/_ext/1599763551/port_asm.o.ok ${OBJECTDIR}/_ext/1599763551/port_asm.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1599763551/port_asm.o.d" "${OBJECTDIR}/_ext/1599763551/port_asm.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../" -MMD -MF "${OBJECTDIR}/_ext/1599763551/port_asm.o.d"  -o ${OBJECTDIR}/_ext/1599763551/port_asm.o ../../../FreeRTOS/Source/portable/MPLAB/PIC32MX/port_asm.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1599763551/port_asm.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../"
	
${OBJECTDIR}/_ext/1472/Ethernet_ISR.o: ../Ethernet_ISR.S  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/Ethernet_ISR.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/Ethernet_ISR.o 
	@${RM} ${OBJECTDIR}/_ext/1472/Ethernet_ISR.o.ok ${OBJECTDIR}/_ext/1472/Ethernet_ISR.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/Ethernet_ISR.o.d" "${OBJECTDIR}/_ext/1472/Ethernet_ISR.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../" -MMD -MF "${OBJECTDIR}/_ext/1472/Ethernet_ISR.o.d"  -o ${OBJECTDIR}/_ext/1472/Ethernet_ISR.o ../Ethernet_ISR.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1472/Ethernet_ISR.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../"
	
${OBJECTDIR}/_ext/1472/PHY_isr.o: ../PHY_isr.S  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/PHY_isr.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/PHY_isr.o 
	@${RM} ${OBJECTDIR}/_ext/1472/PHY_isr.o.ok ${OBJECTDIR}/_ext/1472/PHY_isr.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/PHY_isr.o.d" "${OBJECTDIR}/_ext/1472/PHY_isr.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../" -MMD -MF "${OBJECTDIR}/_ext/1472/PHY_isr.o.d"  -o ${OBJECTDIR}/_ext/1472/PHY_isr.o ../PHY_isr.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1472/PHY_isr.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../"
	
else
${OBJECTDIR}/_ext/1599763551/port_asm.o: ../../../FreeRTOS/Source/portable/MPLAB/PIC32MX/port_asm.S  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1599763551" 
	@${RM} ${OBJECTDIR}/_ext/1599763551/port_asm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1599763551/port_asm.o 
	@${RM} ${OBJECTDIR}/_ext/1599763551/port_asm.o.ok ${OBJECTDIR}/_ext/1599763551/port_asm.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1599763551/port_asm.o.d" "${OBJECTDIR}/_ext/1599763551/port_asm.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../" -MMD -MF "${OBJECTDIR}/_ext/1599763551/port_asm.o.d"  -o ${OBJECTDIR}/_ext/1599763551/port_asm.o ../../../FreeRTOS/Source/portable/MPLAB/PIC32MX/port_asm.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1599763551/port_asm.o.asm.d",--gdwarf-2,-I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../"
	
${OBJECTDIR}/_ext/1472/Ethernet_ISR.o: ../Ethernet_ISR.S  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/Ethernet_ISR.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/Ethernet_ISR.o 
	@${RM} ${OBJECTDIR}/_ext/1472/Ethernet_ISR.o.ok ${OBJECTDIR}/_ext/1472/Ethernet_ISR.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/Ethernet_ISR.o.d" "${OBJECTDIR}/_ext/1472/Ethernet_ISR.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../" -MMD -MF "${OBJECTDIR}/_ext/1472/Ethernet_ISR.o.d"  -o ${OBJECTDIR}/_ext/1472/Ethernet_ISR.o ../Ethernet_ISR.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1472/Ethernet_ISR.o.asm.d",--gdwarf-2,-I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../"
	
${OBJECTDIR}/_ext/1472/PHY_isr.o: ../PHY_isr.S  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/PHY_isr.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/PHY_isr.o 
	@${RM} ${OBJECTDIR}/_ext/1472/PHY_isr.o.ok ${OBJECTDIR}/_ext/1472/PHY_isr.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/PHY_isr.o.d" "${OBJECTDIR}/_ext/1472/PHY_isr.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../" -MMD -MF "${OBJECTDIR}/_ext/1472/PHY_isr.o.d"  -o ${OBJECTDIR}/_ext/1472/PHY_isr.o ../PHY_isr.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1472/PHY_isr.o.asm.d",--gdwarf-2,-I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1599763551/port.o: ../../../FreeRTOS/Source/portable/MPLAB/PIC32MX/port.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1599763551" 
	@${RM} ${OBJECTDIR}/_ext/1599763551/port.o.d 
	@${RM} ${OBJECTDIR}/_ext/1599763551/port.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1599763551/port.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1599763551/port.o.d" -o ${OBJECTDIR}/_ext/1599763551/port.o ../../../FreeRTOS/Source/portable/MPLAB/PIC32MX/port.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/190470153/event_groups.o: ../../../FreeRTOS/Source/event_groups.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/190470153" 
	@${RM} ${OBJECTDIR}/_ext/190470153/event_groups.o.d 
	@${RM} ${OBJECTDIR}/_ext/190470153/event_groups.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/190470153/event_groups.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/190470153/event_groups.o.d" -o ${OBJECTDIR}/_ext/190470153/event_groups.o ../../../FreeRTOS/Source/event_groups.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/190470153/list.o: ../../../FreeRTOS/Source/list.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/190470153" 
	@${RM} ${OBJECTDIR}/_ext/190470153/list.o.d 
	@${RM} ${OBJECTDIR}/_ext/190470153/list.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/190470153/list.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/190470153/list.o.d" -o ${OBJECTDIR}/_ext/190470153/list.o ../../../FreeRTOS/Source/list.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/190470153/queue.o: ../../../FreeRTOS/Source/queue.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/190470153" 
	@${RM} ${OBJECTDIR}/_ext/190470153/queue.o.d 
	@${RM} ${OBJECTDIR}/_ext/190470153/queue.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/190470153/queue.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/190470153/queue.o.d" -o ${OBJECTDIR}/_ext/190470153/queue.o ../../../FreeRTOS/Source/queue.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/190470153/tasks.o: ../../../FreeRTOS/Source/tasks.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/190470153" 
	@${RM} ${OBJECTDIR}/_ext/190470153/tasks.o.d 
	@${RM} ${OBJECTDIR}/_ext/190470153/tasks.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/190470153/tasks.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/190470153/tasks.o.d" -o ${OBJECTDIR}/_ext/190470153/tasks.o ../../../FreeRTOS/Source/tasks.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/636803636/heap_4.o: ../../../FreeRTOS/Source/portable/MemMang/heap_4.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/636803636" 
	@${RM} ${OBJECTDIR}/_ext/636803636/heap_4.o.d 
	@${RM} ${OBJECTDIR}/_ext/636803636/heap_4.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/636803636/heap_4.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/636803636/heap_4.o.d" -o ${OBJECTDIR}/_ext/636803636/heap_4.o ../../../FreeRTOS/Source/portable/MemMang/heap_4.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/1365677990/BufferAllocation_2.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement/BufferAllocation_2.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1365677990" 
	@${RM} ${OBJECTDIR}/_ext/1365677990/BufferAllocation_2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1365677990/BufferAllocation_2.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1365677990/BufferAllocation_2.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1365677990/BufferAllocation_2.o.d" -o ${OBJECTDIR}/_ext/1365677990/BufferAllocation_2.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement/BufferAllocation_2.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_ARP.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_ARP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_ARP.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_ARP.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_ARP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_ARP.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_ARP.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_ARP.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_DHCP.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_DHCP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_DHCP.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_DHCP.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_DHCP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_DHCP.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_DHCP.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_DHCP.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_DNS.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_DNS.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_DNS.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_DNS.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_DNS.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_DNS.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_DNS.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_DNS.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_IP.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_IP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_IP.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_IP.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_IP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_IP.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_IP.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_IP.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_Sockets.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_Sockets.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_Sockets.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_Sockets.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_Sockets.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_Sockets.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_Sockets.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_Sockets.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_Stream_Buffer.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_Stream_Buffer.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_Stream_Buffer.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_Stream_Buffer.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_Stream_Buffer.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_Stream_Buffer.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_Stream_Buffer.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_Stream_Buffer.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_IP.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_TCP_IP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_IP.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_IP.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_IP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_IP.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_IP.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_TCP_IP.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_WIN.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_TCP_WIN.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_WIN.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_WIN.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_WIN.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_WIN.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_WIN.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_TCP_WIN.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_UDP_IP.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_UDP_IP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_UDP_IP.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_UDP_IP.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_UDP_IP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_UDP_IP.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_UDP_IP.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_UDP_IP.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/1472/NetworkInterface.o: ../NetworkInterface.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/NetworkInterface.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/NetworkInterface.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/NetworkInterface.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1472/NetworkInterface.o.d" -o ${OBJECTDIR}/_ext/1472/NetworkInterface.o ../NetworkInterface.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/1472/PHYGeneric.o: ../PHYGeneric.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/PHYGeneric.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/PHYGeneric.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/PHYGeneric.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1472/PHYGeneric.o.d" -o ${OBJECTDIR}/_ext/1472/PHYGeneric.o ../PHYGeneric.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhy.o: ../ETHPIC32ExtPhy.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhy.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhy.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhy.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhy.o.d" -o ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhy.o ../ETHPIC32ExtPhy.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhySMSC8720.o: ../ETHPIC32ExtPhySMSC8720.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhySMSC8720.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhySMSC8720.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhySMSC8720.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhySMSC8720.o.d" -o ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhySMSC8720.o ../ETHPIC32ExtPhySMSC8720.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/1472/LAN8720A.o: ../LAN8720A.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/LAN8720A.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/LAN8720A.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/LAN8720A.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1472/LAN8720A.o.d" -o ${OBJECTDIR}/_ext/1472/LAN8720A.o ../LAN8720A.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/1472/chipKIT_PRO_MX7.o: ../chipKIT_PRO_MX7.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/chipKIT_PRO_MX7.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/chipKIT_PRO_MX7.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/chipKIT_PRO_MX7.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1472/chipKIT_PRO_MX7.o.d" -o ${OBJECTDIR}/_ext/1472/chipKIT_PRO_MX7.o ../chipKIT_PRO_MX7.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/1472/main.o: ../main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/main.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/main.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1472/main.o.d" -o ${OBJECTDIR}/_ext/1472/main.o ../main.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
else
${OBJECTDIR}/_ext/1599763551/port.o: ../../../FreeRTOS/Source/portable/MPLAB/PIC32MX/port.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1599763551" 
	@${RM} ${OBJECTDIR}/_ext/1599763551/port.o.d 
	@${RM} ${OBJECTDIR}/_ext/1599763551/port.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1599763551/port.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1599763551/port.o.d" -o ${OBJECTDIR}/_ext/1599763551/port.o ../../../FreeRTOS/Source/portable/MPLAB/PIC32MX/port.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/190470153/event_groups.o: ../../../FreeRTOS/Source/event_groups.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/190470153" 
	@${RM} ${OBJECTDIR}/_ext/190470153/event_groups.o.d 
	@${RM} ${OBJECTDIR}/_ext/190470153/event_groups.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/190470153/event_groups.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/190470153/event_groups.o.d" -o ${OBJECTDIR}/_ext/190470153/event_groups.o ../../../FreeRTOS/Source/event_groups.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/190470153/list.o: ../../../FreeRTOS/Source/list.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/190470153" 
	@${RM} ${OBJECTDIR}/_ext/190470153/list.o.d 
	@${RM} ${OBJECTDIR}/_ext/190470153/list.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/190470153/list.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/190470153/list.o.d" -o ${OBJECTDIR}/_ext/190470153/list.o ../../../FreeRTOS/Source/list.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/190470153/queue.o: ../../../FreeRTOS/Source/queue.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/190470153" 
	@${RM} ${OBJECTDIR}/_ext/190470153/queue.o.d 
	@${RM} ${OBJECTDIR}/_ext/190470153/queue.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/190470153/queue.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/190470153/queue.o.d" -o ${OBJECTDIR}/_ext/190470153/queue.o ../../../FreeRTOS/Source/queue.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/190470153/tasks.o: ../../../FreeRTOS/Source/tasks.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/190470153" 
	@${RM} ${OBJECTDIR}/_ext/190470153/tasks.o.d 
	@${RM} ${OBJECTDIR}/_ext/190470153/tasks.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/190470153/tasks.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/190470153/tasks.o.d" -o ${OBJECTDIR}/_ext/190470153/tasks.o ../../../FreeRTOS/Source/tasks.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/636803636/heap_4.o: ../../../FreeRTOS/Source/portable/MemMang/heap_4.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/636803636" 
	@${RM} ${OBJECTDIR}/_ext/636803636/heap_4.o.d 
	@${RM} ${OBJECTDIR}/_ext/636803636/heap_4.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/636803636/heap_4.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/636803636/heap_4.o.d" -o ${OBJECTDIR}/_ext/636803636/heap_4.o ../../../FreeRTOS/Source/portable/MemMang/heap_4.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/1365677990/BufferAllocation_2.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement/BufferAllocation_2.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1365677990" 
	@${RM} ${OBJECTDIR}/_ext/1365677990/BufferAllocation_2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1365677990/BufferAllocation_2.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1365677990/BufferAllocation_2.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1365677990/BufferAllocation_2.o.d" -o ${OBJECTDIR}/_ext/1365677990/BufferAllocation_2.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement/BufferAllocation_2.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_ARP.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_ARP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_ARP.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_ARP.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_ARP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_ARP.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_ARP.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_ARP.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_DHCP.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_DHCP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_DHCP.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_DHCP.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_DHCP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_DHCP.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_DHCP.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_DHCP.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_DNS.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_DNS.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_DNS.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_DNS.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_DNS.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_DNS.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_DNS.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_DNS.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_IP.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_IP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_IP.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_IP.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_IP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_IP.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_IP.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_IP.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_Sockets.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_Sockets.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_Sockets.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_Sockets.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_Sockets.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_Sockets.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_Sockets.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_Sockets.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_Stream_Buffer.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_Stream_Buffer.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_Stream_Buffer.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_Stream_Buffer.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_Stream_Buffer.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_Stream_Buffer.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_Stream_Buffer.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_Stream_Buffer.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_IP.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_TCP_IP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_IP.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_IP.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_IP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_IP.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_IP.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_TCP_IP.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_WIN.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_TCP_WIN.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_WIN.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_WIN.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_WIN.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_WIN.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_TCP_WIN.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_TCP_WIN.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/801913726/FreeRTOS_UDP_IP.o: ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_UDP_IP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/801913726" 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_UDP_IP.o.d 
	@${RM} ${OBJECTDIR}/_ext/801913726/FreeRTOS_UDP_IP.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/801913726/FreeRTOS_UDP_IP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/801913726/FreeRTOS_UDP_IP.o.d" -o ${OBJECTDIR}/_ext/801913726/FreeRTOS_UDP_IP.o ../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/FreeRTOS_UDP_IP.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/1472/NetworkInterface.o: ../NetworkInterface.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/NetworkInterface.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/NetworkInterface.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/NetworkInterface.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1472/NetworkInterface.o.d" -o ${OBJECTDIR}/_ext/1472/NetworkInterface.o ../NetworkInterface.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/1472/PHYGeneric.o: ../PHYGeneric.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/PHYGeneric.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/PHYGeneric.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/PHYGeneric.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1472/PHYGeneric.o.d" -o ${OBJECTDIR}/_ext/1472/PHYGeneric.o ../PHYGeneric.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhy.o: ../ETHPIC32ExtPhy.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhy.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhy.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhy.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhy.o.d" -o ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhy.o ../ETHPIC32ExtPhy.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhySMSC8720.o: ../ETHPIC32ExtPhySMSC8720.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhySMSC8720.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhySMSC8720.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhySMSC8720.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhySMSC8720.o.d" -o ${OBJECTDIR}/_ext/1472/ETHPIC32ExtPhySMSC8720.o ../ETHPIC32ExtPhySMSC8720.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/1472/LAN8720A.o: ../LAN8720A.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/LAN8720A.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/LAN8720A.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/LAN8720A.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1472/LAN8720A.o.d" -o ${OBJECTDIR}/_ext/1472/LAN8720A.o ../LAN8720A.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/1472/chipKIT_PRO_MX7.o: ../chipKIT_PRO_MX7.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/chipKIT_PRO_MX7.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/chipKIT_PRO_MX7.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/chipKIT_PRO_MX7.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1472/chipKIT_PRO_MX7.o.d" -o ${OBJECTDIR}/_ext/1472/chipKIT_PRO_MX7.o ../chipKIT_PRO_MX7.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
${OBJECTDIR}/_ext/1472/main.o: ../main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/main.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1472/main.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -D_SUPPRESS_PLIB_WARNING -I"../" -I"../../../FreeRTOS/Source" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/BufferManagement" -I"../../../FreeRTOS/Source/portable/MemMang" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS/Source/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC32MX" -I"../../../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include" -MMD -MF "${OBJECTDIR}/_ext/1472/main.o.d" -o ${OBJECTDIR}/_ext/1472/main.o ../main.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD) 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/TCP_Echo_Server.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mdebugger -D__MPLAB_DEBUGGER_PK3=1 -mprocessor=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/TCP_Echo_Server.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)   -mreserve=data@0x0:0x1FC -mreserve=boot@0x1FC02000:0x1FC02FEF -mreserve=boot@0x1FC02000:0x1FC024FF  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/TCP_Echo_Server.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/TCP_Echo_Server.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"
	${MP_CC_DIR}\\xc32-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/TCP_Echo_Server.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
