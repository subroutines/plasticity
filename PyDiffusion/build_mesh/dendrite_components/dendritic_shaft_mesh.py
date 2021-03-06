import dolfin
import numpy as np


if not dolfin.has_cgal():
  raise ImportError('Does not have CGAL.')
else:
  print 'Done importing'
  print '=' * 60


SCALE_FACTOR = 50  # dolfin.Mesh has issues below a certain scale
# Top cone data for synapse
TOP_CONE_TOP_Z = SCALE_FACTOR * 1.0
TOP_CONE_TOP_RADIUS = SCALE_FACTOR * 0.2
# Cone boundary data for synapse
CONE_BOUNDARY_Z = SCALE_FACTOR * (1.0 - 0.16)
CONE_BOUNDARY_RADIUS = SCALE_FACTOR * 0.3
# Bottom cone data for synapse
BOTTOM_CONE_BOTTOM_Z = SCALE_FACTOR * (1.0 - 3 * 0.16)
BOTTOM_CONE_BOTTOM_RADIUS = SCALE_FACTOR * 0.1
# Cylinder data for dendritic shaft
CYLINDER_TOP = BOTTOM_CONE_BOTTOM_Z
CYLINDER_BOTTOM = SCALE_FACTOR * 0.0
CYLINDER_RADIUS = SCALE_FACTOR * 0.1


def get_top_cone():
  return dolfin.Cone(dolfin.Point(0, 0, CONE_BOUNDARY_Z),
                     dolfin.Point(0, 0, TOP_CONE_TOP_Z),
                     CONE_BOUNDARY_RADIUS, TOP_CONE_TOP_RADIUS)


def get_bottom_cone():
  return dolfin.Cone(dolfin.Point(0, 0, BOTTOM_CONE_BOTTOM_Z),
                     dolfin.Point(0, 0, CONE_BOUNDARY_Z),
                     BOTTOM_CONE_BOTTOM_RADIUS, CONE_BOUNDARY_RADIUS)


def get_cylinder():
  return dolfin.Cone(dolfin.Point(0, 0, CYLINDER_BOTTOM),
                     dolfin.Point(0, 0, CYLINDER_TOP),
                     CYLINDER_RADIUS, CYLINDER_RADIUS)


def get_geometry():
  top_cone = get_top_cone()
  bottom_cone = get_bottom_cone()
  cylinder = get_cylinder()
  return top_cone + bottom_cone + cylinder


def main():
  geometry_3d = get_geometry()
  dolfin.info(geometry_3d, True)
  resolution = 32
  print '=' * 60
  print 'Creating mesh'
  print '=' * 60
  mesh_3d = dolfin.Mesh(geometry_3d, resolution)
  print '=' * 60
  print 'Plotting in interactive mode'
  print '=' * 60
  dolfin.plot(mesh_3d, '3D mesh', interactive=True)


if __name__ == '__main__':
  main()
