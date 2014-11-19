/* Copyright (C) 2014 PISM Authors
 *
 * This file is part of PISM.
 *
 * PISM is free software; you can redistribute it and/or modify it under the
 * terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 3 of the License, or (at your option) any later
 * version.
 *
 * PISM is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License
 * along with PISM; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/

#ifndef _PS_FEvoR_H_
#define _PS_FEvoR_H_

#include "PS_EISMINTII.hh"

namespace pism {

/** PISM-FEvoR climate inputs.
 *
 */
class PS_FEvoR : public PS_EISMINTII {
public:
  PS_FEvoR(IceGrid &g, const Config &conf);
  virtual ~PS_FEvoR();
  // the interface:
  PetscErrorCode init(Vars &vars);
};


} // end of namespace pism

#endif /* _PS_FEvoR_H_ */