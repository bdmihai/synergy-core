/*
 * synergy -- mouse and keyboard sharing utility
 * Copyright (C) 2015-2016 Symless Ltd.
 *
 * This package is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * found in the file LICENSE that should have accompanied this file.
 *
 * This package is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "SecureListenSocket.h"

#include "SecureSocket.h"
#include "net/NetworkAddress.h"
#include "net/SocketMultiplexer.h"
#include "net/TSocketMultiplexerMethodJob.h"
#include "arch/XArch.h"

static const char s_certificateDir[] = { "SSL" };
static const char s_certificateFilename[] = { "Synergy.pem" };

//
// SecureListenSocket
//

SecureListenSocket::SecureListenSocket(
  IEventQueue *events,
  SocketMultiplexer *socketMultiplexer) :
  TCPListenSocket(events, socketMultiplexer)
{
}

SecureListenSocket::~SecureListenSocket()
{
  for (auto socket : m_secureSocketSet) {
//    delete socket;
  }
  m_secureSocketSet.clear();
}

IDataSocket *
SecureListenSocket::accept()
{
  SecureSocket *socket = nullptr;
  try {
    socket = new SecureSocket(
      m_events,
      m_socketMultiplexer,
      ARCH->acceptSocket(m_socket, nullptr));
    socket->initSsl(true);

    if (socket != nullptr) {
      setListeningJob();
    }

    String certificateFilename = synergy::string::sprintf("%s/%s/%s",
                                 ARCH->getProfileDirectory().c_str(),
                                 s_certificateDir,
                                 s_certificateFilename);

    bool loaded = socket->loadCertificates(certificateFilename);
    if (!loaded) {
      delete socket;
      return nullptr;
    }

    socket->secureAccept();

    m_secureSocketSet.insert(socket);

    return dynamic_cast<IDataSocket *>(socket);
  } catch (XArchNetwork &) {
    if (socket != nullptr) {
      delete socket;
      setListeningJob();
    }
    return nullptr;
  } catch (std::exception &ex) {
    if (socket != nullptr) {
      delete socket;
      setListeningJob();
    }
    throw ex;
  }
}
