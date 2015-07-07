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

#include "base/util/PISMComponent.hh"
#include "base/util/iceModelVec.hh"
#include "base/stressbalance/PISMStressBalance.hh"
// #include <fevor_distribution.hh>
#include "base/util/MaxTimestep.hh"
#include <mpi.h>
#include <list>
namespace pism {

  class EnthalpyConverter;
namespace stressbalance {
class StressBalance;
}



  
/*! PISM Lagrange tracer tracking. 
 *  
 * This all is based on Joe Kennedy's FEvoR
 *  */
  
class PISMLagrange : public Component_TS {
public:
  PISMLagrange(IceGrid::ConstPtr g, stressbalance::StressBalance *stress_balance);
  virtual ~PISMLagrange();

  void init();

  virtual MaxTimestep max_timestep_impl(double t);
  virtual void update_impl(double t, double dt);

  virtual void add_vars_to_output_impl(const std::string &keyword, std::set<std::string> &result);

  virtual void define_variables_impl(const std::set<std::string> &vars, const PIO &nc,
                                          IO_Type nctype);

  virtual void write_variables_impl(const std::set<std::string> &vars, const PIO& nc);
  typedef struct {
  double x, y, z;
  int  rank, id;
  }          Particle;
  
private:
  MPI_Datatype particletype;
  stressbalance::StressBalance *m_stress_balance;

  std::list<Particle> particles;

  void allocate();

  void set_initial_distribution_parameters();

  void load_distributions(const std::string &input_file);
  void save_distributions(const PIO &nc);

  void save_diagnostics(const PIO &nc);
  void save_particle_positions(const PIO &nc);
  void update_particle_position(double &x, double &y, double &z,
                                          double u, double v, double w,
                                          double m_dt);

  void evaluate_at_point(const IceModelVec3 &input,
                                   double x, double y, double z,
                                   double &result);

  void pointcloud_to_grid(const std::vector<double> &x,
                                    const std::vector<double> &y,
                                    const std::vector<double> &z,
                                    const std::vector<double> &values,
                                    IceModelVec3 &result);

  int neighbors [9]; // neighbors in i and j direction. 
  void compute_neighbors();
  void ship_tracers();
  int whereto(double x , double y, double z);
  void load_particle_positions(const pism::PIO &nc,
			       unsigned int time_index);

}; // End of PISMLagrange class

} // End of namespace pism