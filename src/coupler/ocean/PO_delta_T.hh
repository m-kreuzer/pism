// Copyright (C) 2011, 2012, 2013, 2014, 2015 PISM Authors
//
// This file is part of PISM.
//
// PISM is free software; you can redistribute it and/or modify it under the
// terms of the GNU General Public License as published by the Free Software
// Foundation; either version 3 of the License, or (at your option) any later
// version.
//
// PISM is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
// details.
//
// You should have received a copy of the GNU General Public License
// along with PISM; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

#ifndef _PODTFORCING_H_
#define _PODTFORCING_H_

#include "PScalarForcing.hh"
#include "PISMOcean.hh"
#include "POModifier.hh"

namespace pism {

//! \brief Forcing using shelf base temperature scalar time-dependent offsets.
class PO_delta_T : public PScalarForcing<OceanModel,POModifier>
{
public:
  PO_delta_T(const IceGrid &g, OceanModel* in);
  virtual ~PO_delta_T();

protected:
  virtual void write_variables_impl(const std::set<std::string> &vars, const PIO &nc);
  virtual void add_vars_to_output_impl(const std::string &keyword, std::set<std::string> &result);
  virtual void define_variables_impl(const std::set<std::string> &vars, const PIO &nc,
                                          IO_Type nctype);
  virtual void init_impl();
  virtual void shelf_base_temperature_impl(IceModelVec2S &result);
protected:
  NCSpatialVariable shelfbmassflux, shelfbtemp;
};

} // end of namespace pism

#endif /* _PODTFORCING_H_ */
