/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/
module derelict.ode.types;

private {
    import std.math;
    import core.vararg;
    import core.stdc.config;
    import core.stdc.time;
    import derelict.util.system;
}

// odeconfig.h
alias dint64 = long;
alias duint64 = ulong;
alias dint32 = int;
alias duint32 = uint;
alias dint16 = short;
alias duint16 = ushort;
alias dint8 = byte;
alias duint8 = ubyte;

version( DerelictODE_Single ) {
    enum dDOUBLE = false;
    enum dSINGLE = true;
} else {
    enum dDOUBLE = true;
    enum dSINGLE = false;
}

static if( dSINGLE )
    enum dInfinity = float.infinity;
else
    enum dInfinity = double.infinity;

// common.h
alias M_PI = PI;
alias M_PI_2 = PI_2;
alias M_SQRT1_2 = SQRT1_2;

static if( dSINGLE )
    alias dReal = float;
else
    alias dReal = double;

version ( DerelictOde_TriMesh_16Bit_Indices ) {
    version ( DerelictOde_TriMesh_GIMPACT )
        alias dTriIndex = duint32;
    else
        alias dTriIndex = duint16;
} else {
    alias dTriIndex = duint32;
}

int dPAD( int a ) {
    return ( a > 1 ) ? ( ( ( a - 1 )|3 )+1 ) : a;
}

alias dVector3 = dReal[4];
alias dVector4 = dReal[4];
alias dMatrix3 = dReal[4*3];
alias dMatrix4 = dReal[4*4];
alias dMatrix6 = dReal[8*6];
alias dQuaternion = dReal[4];

dReal dRecip( dReal x ) {
    return 1.0/x;
}

dReal dRecipSqrt( dReal x ) {
    return 1.0/sqrt( x );
}

dReal dFMod( dReal a, dReal b ) {
    real c;
    return modf( a, c );
}

alias dSqrt = sqrt;
alias dSin = sin;
alias dCos = cos;
alias dFabs = fabs;
alias dAtan2 = atan2;
alias dAcos = acos;
alias dFMod = fmod;
alias dFloor = floor;
alias dCeil = ceil;
alias dCopySign = copysign;
alias dNextAfter = nextafter;
alias dIsNan = isnan;

struct dxWorld;
struct dxSpace;
struct dxBody;
struct dxGeom;
struct dxJoint;
struct dxJointNode;
struct dxJointGroup;
struct dxWorldProcessThreadingManager;

alias dWorldID = dxWorld*;
alias dSpaceID = dxSpace*;
alias dBodyID = dxBody*;
alias dGeomID = dxGeom*;
alias dJointID = dxJoint*;
alias dJointGroupID = dxJointGroup*;
alias dWorldStepThreadingManagerId = dxWorldProcessThreadingManager*;

enum {
    d_ERR_UNKNOWN = 0,
    d_ERR_IASSERT,
    d_ERR_UASSERT,
    d_ERR_LCP
}

alias dJointType = int;
enum {
    dJointTypeNone = 0,
    dJointTypeBall,
    dJointTypeHinge,
    dJointTypeSlider,
    dJointTypeContact,
    dJointTypeUniversal,
    dJointTypeHinge2,
    dJointTypeFixed,
    dJointTypeNull,
    dJointTypeAMotor,
    dJointTypeLMotor,
    dJointTypePlane2D,
    dJointTypePR,
    dJointTypePU,
    dJointTypePiston,
    dJointTypeDBall,
    dJointTypeDHinge,
    dJointTypeTransmission,
}

enum {
    dParamLoStop = 0,
    dParamHiStop,
    dParamVel,
    dParamFMax,
    dParamFudgeFactor,
    dParamBounce,
    dParamCFM,
    dParamStopERP,
    dParamStopCFM,
    dParamSuspensionERP,
    dParamSuspensionCFM,
    dParamERP,
    dParamsInGroup,
    dParamLoStop1 = 0x000,
    dParamHiStop1,
    dParamVel1,
    dParamFMax1,
    dParamFudgeFactor1,
    dParamBounce1,
    dParamCFM1,
    dParamStopERP1,
    dParamStopCFM1,
    dParamSuspensionERP1,
    dParamSuspensionCFM1,
    dParamERP1,
    dParamLoStop2 = 0x100,
    dParamHiStop2,
    dParamVel2,
    dParamFMax2,
    dParamFudgeFactor2,
    dParamBounce2,
    dParamCFM2,
    dParamStopERP2,
    dParamStopCFM2,
    dParamSuspensionERP2,
    dParamSuspensionCFM2,
    dParamERP2,
    dParamLoStop3 = 0x200,
    dParamHiStop3,
    dParamVel3,
    dParamFMax3,
    dParamFudgeFactor3,
    dParamBounce3,
    dParamCFM3,
    dParamStopERP3,
    dParamStopCFM3,
    dParamSuspensionERP3,
    dParamSuspensionCFM3,
    dParamERP3,
    dParamGroup = 0x100
}

enum {
    dAMotorUser  = 0,
    dAMotorEuler = 1,
}

enum {
    dTransmissionParallelAxes = 0,
    dTransmissionIntersectingAxes = 1,
    dTransmissionChainDrive = 2,
}

struct dJointFeedback {
    dVector3 f1;
    dVector3 t1;
    dVector3 f2;
    dVector3 t2;
}

// collision.h
enum {
    dGeomCommonControlClass = 0,
    dGeomColliderControlClass = 1
}

enum {
    dGeomCommonAnyControlCode = 0,

    dGeomColliderSetMergeSphereContactsControlCode = 1,
    dGeomColliderGetMergeSphereContactsControlCode = 2
}

enum {
    dGeomColliderMergeContactsValue__Default = 0,
    dGeomColliderMergeContactsValue_None = 1,
    dGeomColliderMergeContactsValue_Normals = 2,
    dGeomColliderMergeContactsValue_Full = 3
}

enum {
    CONTACTS_UNIMPORTANT = 0x80000000
}

enum {
    dMaxUserClasses = 4
}

enum {
    dSphereClass = 0,
    dBoxClass,
    dCapsuleClass,
    dCylinderClass,
    dPlaneClass,
    dRayClass,
    dConvexClass,
    dGeomTransformClass,
    dTriMeshClass,
    dHeightFieldClass,
    dFirstSpaceClass,
    dSimpleSpaceClass = dFirstSpaceClass,
    dHashSpaceClass,
    dSweepAndPruneSpaceClass,
    dQuadTreeClass,
    dLastSpaceClass = dQuadTreeClass,
    dFirstUserClass,
    dLastUserClass = dFirstUserClass + dMaxUserClasses - 1,
    dGeomNumClasses
}

alias dCCylinderClass = dCapsuleClass;

struct dxHeightfieldData;
alias dxHeightfieldData* dHeightfieldDataID;

extern( C ) nothrow {
    alias dHeightfieldGetHeight = dReal function( void*, int, int );
    alias dGetAABBFn = void function( dGeomID, ref dReal[6] );
    alias dColliderFn = int function( dGeomID, dGeomID, int, dContactGeom*, int );
    alias dGetColliderFnFn = dColliderFn function( int );
    alias dGeomDtorFn = void function( dGeomID );
    alias dAABBTestFn = int function( dGeomID, dGeomID, ref dReal[6] );
}


struct dGeomClass {
    int bytes;
    dGetColliderFnFn collider;
    dGetAABBFn aabb;
    dAABBTestFn aabb_test;
    dGeomDtorFn dtor;
}

// collision_space.h
extern( C ) @nogc nothrow alias dNearCallback = void function( void*, dGeomID, dGeomID );

enum {
    dSAP_AXES_XYZ = ( ( 0 )|( 1<<2 )|( 2<<4 ) ),
    dSAP_AXES_XZY = ( ( 0 )|( 2<<2 )|( 1<<4 ) ),
    dSAP_AXES_YXZ = ( ( 1 )|( 0<<2 )|( 2<<4 ) ),
    dSAP_AXES_YZX = ( ( 1 )|( 2<<2 )|( 0<<4 ) ),
    dSAP_AXES_ZXY = ( ( 2 )|( 0<<2 )|( 1<<4 ) ),
    dSAP_AXES_ZYX = ( ( 2 )|( 1<<2 )|( 0<<4 ) )
}

// collision_trimesh.h
struct dxTriMeshData;
alias dxTriMeshData* dTriMeshDataID;

enum { TRIMESH_FACE_NORMALS }

extern( C ) @nogc nothrow {
    alias dTriCallback = int function( dGeomID, dGeomID, int );
    alias dTriArrayCallback = void function( dGeomID, dGeomID, const( int )*, int );
    alias dTriRayCallback = int function( dGeomID, dGeomID, int, dReal, dReal );
    alias dTriTriMergeCallback = int function( dGeomID, int, int );
}

// contact.h
enum {
    dContactMu2 = 0x001,
    dContactFDir1 = 0x002,
    dContactBounce = 0x004,
    dContactSoftERP = 0x008,
    dContactSoftCFM = 0x010,
    dContactMotion1 = 0x020,
    dContactMotion2 = 0x040,
    dContactMotionN = 0x080,
    dContactSlip1 = 0x100,
    dContactSlip2 = 0x200,
    dContactRolling = 0x400,

    dContactApprox0 = 0x0000,
    dContactApprox1_1 = 0x1000,
    dContactApprox1_2 = 0x2000,
    dContactApprox1_N = 0x4000,
    dContactApprox1   = 0x7000,
}

struct dSurfaceParameters {
    int mode;
    dReal mu;
    dReal mu2;
    dReal rho;
    dReal rho2;
    dReal rhoN;
    dReal bounce;
    dReal bounce_vel;
    dReal soft_erp;
    dReal soft_cfm;
    dReal motion1, motion2, motionN;
    dReal slip1, slip2;
}

struct dContactGeom {
    dVector3 pos;
    dVector3 normal;
    dReal depth;
    dGeomID g1, g2;
    int side1, side2;
}

struct dContact {
    dSurfaceParameters surface;
    dContactGeom geom;
    dVector3 fdir1;
}

// error.h
extern( C ) nothrow alias dMessageFunction = void function( int, const( char )*, va_list ap );

// mass.h
struct dMass {
    dReal mass;
    dVector3 c;
    dMatrix3 I;
}

// memory.h
extern( C ) nothrow {
    alias dAllocFunction = void* function( size_t );
    alias dReallocFunction = void* function( void*, size_t, size_t );
    alias dFreeFunction = void function( void*, size_t );
}

// objects.h
enum dWORLDSTEP_THREADCOUNT_UNLIMITED = 0U;
enum dWORLDSTEP_RESERVEFACTOR_DEFAULT = 1.2f;
enum dWORLDSTEP_RESERVESIZE_DEFAULT = 65536U;

struct dWorldStepReserveInfo {
    uint struct_size;

    float reserve_factor;
    uint  reserve_minimum;
}

struct dWorldStepMemoryFunctionsInfo {
    uint struct_size;

    extern( C ) nothrow {
        void* function( size_t ) alloc_block;
        void* function( void*, size_t, size_t ) shrink_block;
        void  function( void*, size_t ) free_block;
    }
}

// odeinit.h
enum : uint {
    dInitFlagManualThreadCleanup = 0x00000001
}

enum : uint {
    dAllocateFlagsBasicData = 0,
    dAllocateFlagsCollisionData = 0x00000001,
    dAllocateMaskAll = ~0U,
}

// odemath.h
auto dACCESS33( T )( T a, size_t i, size_t j ) {
    return a[i * 4 + j];
}

bool dVALIDVEC3( T )( T v ) {
    return !( dIsNan( v[0] ) || dIsNan( v[1] ) || dIsNan( v[2] ) );
}

bool dVALIDVEC4( T )( T v ) {
    return !( dIsNan( v[0] ) || dIsNan( v[1] ) || dIsNan( v[2] ) || dIsNan( v[3] ) );
}

bool dVALIDMAT3( T )( T m ) {
    return !(
        dIsNan( m[0] ) || dIsNan( m[1] ) || dIsNan( m[2] )  || dIsNan( m[3] ) ||
        dIsNan( m[4] ) || dIsNan( m[5] ) || dIsNan( m[6] )  || dIsNan( m[7] ) ||
        dIsNan( m[8] ) || dIsNan( m[9] ) || dIsNan( m[10] ) || dIsNan( m[11] )
     );
}

bool dVALIDMAT4( T )( T m ) {
    return !(
        dIsNan( m[0] )  || dIsNan( m[1] )  || dIsNan( m[2] )  || dIsNan( m[3] )  ||
        dIsNan( m[4] )  || dIsNan( m[5] )  || dIsNan( m[6] )  || dIsNan( m[7] )  ||
        dIsNan( m[8] )  || dIsNan( m[9] )  || dIsNan( m[10] ) || dIsNan( m[11] ) ||
        dIsNan( m[12] ) || dIsNan( m[13] ) || dIsNan( m[14] ) || dIsNan( m[15] )
     );
}

void dAddVectors3( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dReal res_0, res_1, res_2;
    res_0 = a[0] + b[0];
    res_1 = a[1] + b[1];
    res_2 = a[2] + b[2];

    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}


void dSubtractVectors3( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dReal res_0, res_1, res_2;
    res_0 = a[0] - b[0];
    res_1 = a[1] - b[1];
    res_2 = a[2] - b[2];

    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

void dAddScaledVectors3( dReal* res, const( dReal )* a, const( dReal )* b, dReal a_scale, dReal b_scale ) {
    dReal res_0, res_1, res_2;
    res_0 = a_scale * a[0] + b_scale * b[0];
    res_1 = a_scale * a[1] + b_scale * b[1];
    res_2 = a_scale * a[2] + b_scale * b[2];

    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

void dScaleVector3( dReal* res, dReal nScale ) {
    res[0] *= nScale;
    res[1] *= nScale;
    res[2] *= nScale;
}

void dNegateVector3( dReal* res ) {
    res[0] = -res[0];
    res[1] = -res[1];
    res[2] = -res[2];
}

void dCopyVector3( dReal* res, const( dReal )* a ) {
    dReal res_0, res_1, res_2;
    res_0 = a[0];
    res_1 = a[1];
    res_2 = a[2];

    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

void dCopyScaledVector3( dReal* res, const( dReal )* a, dReal nScale ) {
    dReal res_0, res_1, res_2;
    res_0 = a[0] * nScale;
    res_1 = a[1] * nScale;
    res_2 = a[2] * nScale;

    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

void dCopyNegatedVector3( dReal* res, const( dReal )* a ) {
    dReal res_0, res_1, res_2;
    res_0 = -a[0];
    res_1 = -a[1];
    res_2 = -a[2];

    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

void dCopyVector4( dReal* res, const( dReal )* a ) {
    dReal res_0, res_1, res_2, res_3;
    res_0 = a[0];
    res_1 = a[1];
    res_2 = a[2];
    res_3 = a[3];

    res[0] = res_0; res[1] = res_1; res[2] = res_2; res[3] = res_3;
}

void dCopyMatrix4x4( dReal* res, const( dReal )* a ) {
    dCopyVector4( res + 0, a + 0 );
    dCopyVector4( res + 4, a + 4 );
    dCopyVector4( res + 8, a + 8 );
}

void dCopyMatrix4x3( dReal* res, const( dReal )* a ) {
    dCopyVector3( res + 0, a + 0 );
    dCopyVector3( res + 4, a + 4 );
    dCopyVector3( res + 8, a + 8 );
}

void dGetMatrixColumn3( dReal* res, const( dReal )* a, uint n ) {
    dReal res_0, res_1, res_2;
    res_0 = a[n + 0];
    res_1 = a[n + 4];
    res_2 = a[n + 8];

    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

dReal dCalcVectorLength3( const( dReal )* a ) {
    return dSqrt( a[0] * a[0] + a[1] * a[1] + a[2] * a[2] );
}

dReal dCalcVectorLengthSquare3( const( dReal )* a ) {
    return ( a[0] * a[0] + a[1] * a[1] + a[2] * a[2] );
}

dReal dCalcPointDepth3( const( dReal )* test_p, const( dReal )* plane_p, const( dReal )* plane_n ) {
    return ( plane_p[0] - test_p[0] ) * plane_n[0] + ( plane_p[1] - test_p[1] ) * plane_n[1] + ( plane_p[2] - test_p[2] ) * plane_n[2];
}

dReal _dCalcVectorDot3( const( dReal )* a, const( dReal )* b, uint step_a, uint step_b ) {
    return a[0] * b[0] + a[step_a] * b[step_b] + a[2 * step_a] * b[2 * step_b];
}

dReal dCalcVectorDot3    ( const( dReal )* a, const( dReal )* b ) { return _dCalcVectorDot3( a,b,1,1 ); }
dReal dCalcVectorDot3_13 ( const( dReal )* a, const( dReal )* b ) { return _dCalcVectorDot3( a,b,1,3 ); }
dReal dCalcVectorDot3_31 ( const( dReal )* a, const( dReal )* b ) { return _dCalcVectorDot3( a,b,3,1 ); }
dReal dCalcVectorDot3_33 ( const( dReal )* a, const( dReal )* b ) { return _dCalcVectorDot3( a,b,3,3 ); }
dReal dCalcVectorDot3_14 ( const( dReal )* a, const( dReal )* b ) { return _dCalcVectorDot3( a,b,1,4 ); }
dReal dCalcVectorDot3_41 ( const( dReal )* a, const( dReal )* b ) { return _dCalcVectorDot3( a,b,4,1 ); }
dReal dCalcVectorDot3_44 ( const( dReal )* a, const( dReal )* b ) { return _dCalcVectorDot3( a,b,4,4 ); }

void _dCalcVectorCross3( dReal* res, const( dReal )* a, const( dReal )* b, uint step_res, uint step_a, uint step_b ) {
    dReal res_0, res_1, res_2;
    res_0 = a[  step_a]*b[2*step_b] - a[2*step_a]*b[  step_b];
    res_1 = a[2*step_a]*b[       0] - a[       0]*b[2*step_b];
    res_2 = a[       0]*b[  step_b] - a[  step_a]*b[       0];

    res[         0] = res_0;
    res[  step_res] = res_1;
    res[2*step_res] = res_2;
}

void dCalcVectorCross3    ( dReal* res, const( dReal )* a, const( dReal )* b ) { _dCalcVectorCross3( res, a, b, 1, 1, 1 ); }
void dCalcVectorCross3_114( dReal* res, const( dReal )* a, const( dReal )* b ) { _dCalcVectorCross3( res, a, b, 1, 1, 4 ); }
void dCalcVectorCross3_141( dReal* res, const( dReal )* a, const( dReal )* b ) { _dCalcVectorCross3( res, a, b, 1, 4, 1 ); }
void dCalcVectorCross3_144( dReal* res, const( dReal )* a, const( dReal )* b ) { _dCalcVectorCross3( res, a, b, 1, 4, 4 ); }
void dCalcVectorCross3_411( dReal* res, const( dReal )* a, const( dReal )* b ) { _dCalcVectorCross3( res, a, b, 4, 1, 1 ); }
void dCalcVectorCross3_414( dReal* res, const( dReal )* a, const( dReal )* b ) { _dCalcVectorCross3( res, a, b, 4, 1, 4 ); }
void dCalcVectorCross3_441( dReal* res, const( dReal )* a, const( dReal )* b ) { _dCalcVectorCross3( res, a, b, 4, 4, 1 ); }
void dCalcVectorCross3_444( dReal* res, const( dReal )* a, const( dReal )* b ) { _dCalcVectorCross3( res, a, b, 4, 4, 4 ); }

void dAddVectorCross3( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dReal tmp[3];
    dCalcVectorCross3( tmp.ptr, a, b );
    dAddVectors3( res, res, tmp.ptr );
}

void dSubtractVectorCross3( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dReal tmp[3];
    dCalcVectorCross3( tmp.ptr, a, b );
    dSubtractVectors3( res, res, tmp.ptr );
}

void dSetCrossMatrixPlus( dReal* res, const( dReal )* a, uint skip ) {
    const dReal a_0 = a[0], a_1 = a[1], a_2 = a[2];
    res[1] = -a_2;
    res[2] = +a_1;
    res[skip+0] = +a_2;
    res[skip+2] = -a_0;
    res[2*skip+0] = -a_1;
    res[2*skip+1] = +a_0;
}

void dSetCrossMatrixMinus( dReal* res, const( dReal )* a, uint skip ) {
    const dReal a_0 = a[0], a_1 = a[1], a_2 = a[2];
    res[1] = +a_2;
    res[2] = -a_1;
    res[skip+0] = -a_2;
    res[skip+2] = +a_0;
    res[2*skip+0] = +a_1;
    res[2*skip+1] = -a_0;
}

dReal dCalcPointsDistance3( const( dReal )* a, const( dReal )* b ) {
    dReal res;
    dReal tmp[3];
    dSubtractVectors3( tmp.ptr, a, b );
    res = dCalcVectorLength3( tmp.ptr );
    return res;
}

void dMultiplyHelper0_331( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dReal res_0, res_1, res_2;
    res_0 = dCalcVectorDot3( a, b );
    res_1 = dCalcVectorDot3( a + 4, b );
    res_2 = dCalcVectorDot3( a + 8, b );

    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

void dMultiplyHelper1_331( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dReal res_0, res_1, res_2;
    res_0 = dCalcVectorDot3_41( a, b );
    res_1 = dCalcVectorDot3_41( a + 1, b );
    res_2 = dCalcVectorDot3_41( a + 2, b );

    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

void dMultiplyHelper0_133( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dMultiplyHelper1_331( res, b, a );
}

void dMultiplyHelper1_133( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dReal res_0, res_1, res_2;
    res_0 = dCalcVectorDot3_44( a, b );
    res_1 = dCalcVectorDot3_44( a + 1, b );
    res_2 = dCalcVectorDot3_44( a + 2, b );

    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

void dMultiply0_331( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dMultiplyHelper0_331( res, a, b );
}

void dMultiply1_331( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dMultiplyHelper1_331( res, a, b );
}

void dMultiply0_133( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dMultiplyHelper0_133( res, a, b );
}

void dMultiply0_333( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dMultiplyHelper0_133( res + 0, a + 0, b );
    dMultiplyHelper0_133( res + 4, a + 4, b );
    dMultiplyHelper0_133( res + 8, a + 8, b );
}

void dMultiply1_333( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dMultiplyHelper1_133( res + 0, b, a + 0 );
    dMultiplyHelper1_133( res + 4, b, a + 1 );
    dMultiplyHelper1_133( res + 8, b, a + 2 );
}

void dMultiply2_333( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dMultiplyHelper0_331( res + 0, b, a + 0 );
    dMultiplyHelper0_331( res + 4, b, a + 4 );
    dMultiplyHelper0_331( res + 8, b, a + 8 );
}

void dMultiplyAdd0_331( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dReal tmp[3];
    dMultiplyHelper0_331( tmp.ptr, a, b );
    dAddVectors3( res, res, tmp.ptr );
}

void dMultiplyAdd1_331( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dReal tmp[3];
    dMultiplyHelper1_331( tmp.ptr, a, b );
    dAddVectors3( res, res, tmp.ptr );
}

void dMultiplyAdd0_133( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dReal tmp[3];
    dMultiplyHelper0_133( tmp.ptr, a, b );
    dAddVectors3( res, res, tmp.ptr );
}

void dMultiplyAdd0_333( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dReal tmp[3];
    dMultiplyHelper0_133( tmp.ptr, a + 0, b );
    dAddVectors3( res+ 0, res + 0, tmp.ptr );
    dMultiplyHelper0_133( tmp.ptr, a + 4, b );
    dAddVectors3( res + 4, res + 4, tmp.ptr );
    dMultiplyHelper0_133( tmp.ptr, a + 8, b );
    dAddVectors3( res + 8, res + 8, tmp.ptr );
}

void dMultiplyAdd1_333( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dReal tmp[3];
    dMultiplyHelper1_133( tmp.ptr, b, a + 0 );
    dAddVectors3( res + 0, res + 0, tmp.ptr );
    dMultiplyHelper1_133( tmp.ptr, b, a + 1 );
    dAddVectors3( res + 4, res + 4, tmp.ptr );
    dMultiplyHelper1_133( tmp.ptr, b, a + 2 );
    dAddVectors3( res + 8, res + 8, tmp.ptr );
}

void dMultiplyAdd2_333( dReal* res, const( dReal )* a, const( dReal )* b ) {
    dReal tmp[3];
    dMultiplyHelper0_331( tmp.ptr, b, a + 0 );
    dAddVectors3( res + 0, res + 0, tmp.ptr );
    dMultiplyHelper0_331( tmp.ptr, b, a + 4 );
    dAddVectors3( res + 4, res + 4, tmp.ptr );
    dMultiplyHelper0_331( tmp.ptr, b, a + 8 );
    dAddVectors3( res + 8, res + 8, tmp.ptr );
}

dReal dCalcMatrix3Det( const( dReal )* mat ) {
    dReal det;

    det = mat[0] * ( mat[5]*mat[10] - mat[9]*mat[6] )
        - mat[1] * ( mat[4]*mat[10] - mat[8]*mat[6] )
        + mat[2] * ( mat[4]*mat[9]  - mat[8]*mat[5] );

    return det;
}

dReal dInvertMatrix3( dReal* dst, const( dReal )* ma ) {
    dReal det;
    dReal detRecip;

    det = dCalcMatrix3Det( ma );

    if( det == 0 ) {
        return 0;
    }

    detRecip = dRecip( det );

    dst[0] =  ( ma[5]*ma[10] - ma[6]*ma[9]  ) * detRecip;
    dst[1] =  ( ma[9]*ma[2]  - ma[1]*ma[10] ) * detRecip;
    dst[2] =  ( ma[1]*ma[6]  - ma[5]*ma[2]  ) * detRecip;

    dst[4] =  ( ma[6]*ma[8]  - ma[4]*ma[10] ) * detRecip;
    dst[5] =  ( ma[0]*ma[10] - ma[8]*ma[2]  ) * detRecip;
    dst[6] =  ( ma[4]*ma[2]  - ma[0]*ma[6]  ) * detRecip;

    dst[8] =  ( ma[4]*ma[9]  - ma[8]*ma[5]  ) * detRecip;
    dst[9] =  ( ma[8]*ma[1]  - ma[0]*ma[9]  ) * detRecip;
    dst[10] = ( ma[0]*ma[5]  - ma[1]*ma[4]  ) * detRecip;

    return det;
}

// threading.h
struct dxThreadingImplementation;
alias dThreadingImplementationID = dxThreadingImplementation*;

alias dmutexindex_t = uint;
struct dxMutexGroup;
alias dMutexGroupID = dxMutexGroup*;

extern( C ) @nogc nothrow {
    alias dMutexGroupAllocFunction = dMutexGroupID function( dThreadingImplementationID,dmutexindex_t,const( char* )* );
    alias dMutexGroupFreeFunction = void function( dThreadingImplementationID,dMutexGroupID );
    alias dMutexGroupMutexLockFunction = void function( dThreadingImplementationID,dMutexGroupID,dmutexindex_t );
    alias dMutexGroupMutexUnlockFunction = void function( dThreadingImplementationID,dMutexGroupID,dmutexindex_t );
}

struct dxCallReleasee;
alias dCallReleaseeID = dxCallReleasee*;

struct dxCallWait;
alias dCallWaitID = dxCallWait*;

alias ddependencycount_t = size_t;
alias ddependencychange_t = ptrdiff_t;
alias dcallindex_t = size_t;

struct dThreadedWaitTime {
    time_t wait_sec;
    c_ulong wait_nsec;
}

extern( C ) @nogc nothrow {
    alias dThreadedCallFunction = int function( void*,dcallindex_t,dCallReleaseeID );
    alias dThreadedCallWaitAllocFunction = dCallWaitID function( dThreadingImplementationID );
    alias dThreadedCallWaitResetFunction = void function( dThreadingImplementationID,dCallWaitID );
    alias dThreadedCallWaitFreeFunction = void function( dThreadingImplementationID,dCallWaitID );
    alias dThreadedCallPostFunction = void function( dThreadingImplementationID,int*,dCallReleaseeID*,ddependencycount_t,dCallReleaseeID,dCallWaitID,dThreadedCallFunction*,void*,dcallindex_t,const( char )* );
    alias dThreadedCallDependenciesCountAlterFunction = void function( dThreadingImplementationID,dCallReleaseeID,ddependencychange_t );
    alias dThreadedCallWaitFunction = void function( dThreadingImplementationID,int*,dCallWaitID,const( dThreadedWaitTime )*,const( char )* );
    alias dThreadingImplThreadCountRetrieveFunction = uint function( dThreadingImplementationID );
    alias dThreadingImplResourcesForCallsPreallocateFunction = int function( dThreadingImplementationID,ddependencycount_t );
}

struct dThreadingFunctionsInfo {
    uint struct_size;

    dMutexGroupAllocFunction* alloc_mutex_group;
    dMutexGroupFreeFunction* free_mutex_group;
    dMutexGroupMutexLockFunction* lock_group_mutex;
    dMutexGroupMutexUnlockFunction* unlock_group_mutex;

    dThreadedCallWaitAllocFunction* alloc_call_wait;
    dThreadedCallWaitResetFunction* reset_call_wait;
    dThreadedCallWaitFreeFunction* free_call_wait;

    dThreadedCallPostFunction* post_call;
    dThreadedCallDependenciesCountAlterFunction* alter_call_dependencies_count;
    dThreadedCallWaitFunction* wait_call;

    dThreadingImplThreadCountRetrieveFunction* retrieve_thread_count;
    dThreadingImplResourcesForCallsPreallocateFunction* preallocate_resources_for_calls;
}

// timer.h
struct dStopwatch {
    double time;
    c_ulong cc[2];
}

// version.h
enum dODE_VERSION = "0.13.1";